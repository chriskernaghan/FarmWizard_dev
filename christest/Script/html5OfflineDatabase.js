//
// This file contains the JS functions that support interaction with the HTML database for offline access and for synchonisation
//      
        var dbName = 'Animals';
        var dbVersion = '0.1';
        var displayName = 'Animals';
        var maxSize = 4 * 1024 * 1024; // Set to 4M by default
        var xmlhttp;
        var xmlhttp2;
        var outstandingDownload = 0;
       
        function OpenDatabase() {
            // Create the name value 
            return(openDatabase(dbName, dbVersion, displayName, maxSize));
        }

        function FillDynamicList(pListItemID, pListName, pHerdID, pIsBreeding) {
            FillDynamicList(pListItemID, pListName, pHerdID, pIsBreeding, null);
        }

        function FillDynamicList(pListItemID, pListName,pHerdID,pIsBreeding,pDefaultValue) {
            // Search database Datastore
            var listBox = document.getElementById(pListItemID);
            while (listBox.options.length > 0) {
                listBox.remove(0);
            }

            // if null just return as we may call this sometime if value not set
            if (!listBox) {
                return;
            }
            var sql = "SELECT * FROM DynamicLists where ListName = '" + pListName + "' AND HerdID = '" + pHerdID + "'";
            if (pIsBreeding > 0) {
                sql += " AND IsBreeding = '" + pIsBreeding + "'";
            }
            var extraFilter =  sessionStorage.getItem('ExtraFilter');
            if (extraFilter) {
                if (pListName == 'AnimalList') {
                    if (extraFilter == " AND LastCalvedDate = ''") {
                        sql += " AND Name not like '%(%)%'";
                    }
                    else {
                        sql += " AND Name like '%(%)%'";
                    }
                }
            }
            

            db.transaction(function (transaction) {
                transaction.executeSql(sql, [],
                function (transaction, results) {
                    // results.rows holds the rows returned by the query
                    for (var x = 0; x < results.rows.length; x++) {
                        var row = results.rows.item(x);
                        row.InternalAnimalID
                        var opt = document.createElement("option");
                        listBox.options.add(opt);
                        opt.text = row.Name;
                        opt.value = row.Value;
                        if ((pDefaultValue != null) && (pDefaultValue == row.Value)) {
                            opt.selected = true;
                        }
                    }
                    if (results.rows.length == 0) {
                        App.alert("alert", "No list items for " + pListName);
                        return;
                    }
                    showSelect(listBox);
                        
                },
                 function (transaction, error) {
                     App.alert("alert", "Could not access list item database, perhaps you need to synchronise?" + error.message);
                 });
            });

            return;

        }

        var loc_QueryString = "";
        var loc_Form = "";
        var loc_Title = "";
        function WriteFormValuesWithLocation(pUrl, pForm, pTitle) {
           
            loc_QueryString = pUrl;
            loc_Form = pForm;
            loc_Title = pTitle;

            if (navigator.geolocation) {
                var options = {
                    enableHighAccuracy: true,
                    timeout: 20000,
                    maximumAge: 0
                };
                navigator.geolocation.getCurrentPosition(locationSuccess, locationFail, options);
            }
            else {
                WriteFormValues(pUrl, pForm, pTitle);
            }

        }

        function locationSuccess(position) {
            var latitude = position.coords.latitude;
            var longitude = position.coords.longitude;
            WriteFormValues(loc_QueryString + "&Latitude=" + latitude + "&Longtitude=" + longitude, loc_Form, loc_Title);
        }

        function locationFail(err) {
            WriteFormValues(loc_QueryString, loc_Form, loc_Title);
        }


        function WriteFormValues(pUrl,pForm,pTitle) {
            // Create the name value 

            var db = openDatabase(dbName, dbVersion, displayName, maxSize);
            if (!db) {
                App.alert("alert", "Cant open database");
                return;
            }
            // Build a query string of name value pairs and store in the database
            var queryString = "";
            var elem = pForm.elements;
           
            for (var i = 0; i < elem.length; i++) {
                if (elem[i]) {
                    if (elem[i].type == "checkbox") {
                        var checkValue = "";
                        if (elem[i].checked) {
                            checkValue = "on";
                        }
                        queryString += elem[i].name + "=" + checkValue + "&";
                    }
                    else if ((elem[i].name != "__VIEWSTATE") && (elem[i].name != "__EVENTVALIDATION")) { // Dont writh the view state as not needed
                        queryString += elem[i].name + "=" + elem[i].value + "&";
                    }
                }
            }
            
            var d = new Date();
            
            db.transaction(function (transaction) {
                var sql = "INSERT INTO Forms (DateTimeID,RequestString,Status,Url,Title) VALUES (?,?,?,?,?);";
                transaction.executeSql(sql, [d.getTime(),queryString,0,pUrl,pTitle],
                       function (transaction, results) {    // success handler
                    //          App.alert("alert", "Successfully recorded event");
                       },
                       function (transaction, error) {      // error handler
                               App.alert("alert", "Could not insert form: " + error.message);
                       }
                 );
            });
        
        }

        function formResponse(xmlDoc) {

            var id = xmlDoc.getElementsByTagName("SubmissionID")[0].childNodes[0].nodeValue;
            var message = xmlDoc.getElementsByTagName("Message")[0].childNodes[0].nodeValue;
            var success = xmlDoc.getElementsByTagName("Success")[0].childNodes[0].nodeValue;


            var sql = "UPDATE Forms Set Status = " + success + ",Response = '" + message + "' where DateTimeID = " + id;
            db.transaction(
                function (transaction) {
                    transaction.executeSql(
                    sql, [], function (transaction, results) {    // success handler
                        //     App.alert("alert", "Successful form response recorded " + id);
                    },
                    function (transaction, error) {      // error handler
                        App.alert("alert", "Could not update successful form: " + error.message);
                    }
                    );
                });

            }

            function countWaiting() {
                var sql = "SELECT * FROM Forms where Status = 2";
                db.transaction(
                    function (transaction) {
                        transaction.executeSql(
                        sql, [], function (transaction, results) {    // success handler
                            return (results.rows.length);
                        },
                        function (transaction, error) {      // error handler
                            App.alert("alert", "Cant count outstanding forms " + error.message);
                        }
                        );
                    });


            }

            // Function indicate that form is awaiting a response
            function setFormWaiting(id) {
                var sql = "UPDATE Forms Set Status = 2 where DateTimeID = " + id;
                db.transaction(
                    function (transaction) {
                        transaction.executeSql(
                        sql, [], function (transaction, results) {    // success handler
                            //     App.alert("alert", "Successful form response recorded " + id);
                        },
                        function (transaction, error) {      // error handler
                            App.alert("alert", "Could not update successful form: " + error.message);
                        }
                        );
                    });

                }

                function DelAllEvents() {
                    if (confirm("Are you sure you want to delete all events") == false) {
                        return;
                    }
                    var sql = "Delete from Forms";
                    if (!db) {
                        db = openDatabase(dbName, dbVersion, displayName, maxSize);
                    }
                    if (!db) {
                        App.alert("alert", "Cant open database");
                        return;
                    }
                    db.transaction(
                        function (transaction) {
                            transaction.executeSql(
                            sql, [], function (transaction, results) {    // success handler
                                
                            },
                            function (transaction, error) {      // error handler
                                App.alert("alert", "Could not delete forms: " + error.message);
                            }
                            );
                        });

                    
              }

             

                function EditEvent(eventID, pType) {

                    var table = document.getElementById('EventsTable');

                    for (var i = table.rows.length - 1; i > 0; i--) {
                        table.deleteRow(i);
                    }
                    var sql = "Select * from Forms where DateTimeID = " + eventID;
                    if (!db) {
                        db = openDatabase(dbName, dbVersion, displayName, maxSize);
                    }
                    if (!db) {
                        App.alert("alert", "Cant open database");
                        return;
                    }
                    db.transaction(
                        function (transaction) {
                            transaction.executeSql(
                            sql, [], function (transaction, results) {
                         

                                // Add forms to the table
                                if (results.rows.length == 0) {
                                    App.alert("alert", "No events to display");
                                }
                                if (results.rows.length == 1) {
                                    
                                    var row = results.rows.item(0);

                                    var editTable = document.createElement('table');
                                    editTable.id = "editTable";

                                    //create 2 cells in the row    
                                    var trow = editTable.insertRow(-1);
                                    //create request text
                                    var cell1 = trow.insertCell(0);
                                    var t1 = document.createTextNode("Request");
                                    cell1.appendChild(t1);
                                    //create request field + insert value
                                    var cell2 = trow.insertCell(1);
                                    var t2 = document.createElement("input");
                                    t2.id = "txtRequest";
                                    t2.value = row.RequestString;
                                    cell2.appendChild(t2);

                                    var cell3 = trow.insertCell(2);
                                    var t3 = document.createElement("button");
                                    t3.id = "btnUpdateRequest";
                                    t3.appendChild(document.createTextNode("update"));
                                    t3.onclick = function () { // Note this is a function

                                        db.transaction(
                                           function (transaction) {
                                               transaction.executeSql(
                                               'Update Forms set RequestString = \"' + t2.value + '\" where DateTimeID = ' + eventID,
                                               [], function (transaction, results) {    // success handler
                                                   App.alert("alert", "Successfully updated url");
                                               },
                                                   function (transaction, error) {      // error handler
                                                       App.alert("alert", "Could not update the url: " + error.message);
                                                   }
                                               );
                                           }
                                       );

                                    };
                                    cell3.appendChild(t3);

                                    var trow2 = editTable.insertRow(-1);
                                    //create querystring text
                                    var cell4 = trow2.insertCell(0);
                                    var t4 = document.createTextNode("QueryString");
                                    cell4.appendChild(t4);
                                    //create request field + insert value
                                    var cell5 = trow2.insertCell(1);
                                    var t5 = document.createElement("input");
                                    t5.id = "txtQueryString";
                                    t5.value = row.Url;
                                    cell5.appendChild(t5);

                                    var cell6 = trow2.insertCell(2);
                                    var t6 = document.createElement("button");
                                    t6.id = "btnUpdateQuery";
                                    t6.appendChild(document.createTextNode("update"));
                                    t6.onclick = function () { // Note this is a function

                                        db.transaction(
                                           function (transaction) {
                                               transaction.executeSql(
                                               'Update Forms set Url = \"' + t5.value + '\" where DateTimeID = ' + eventID,
                                               [], function (transaction, results) {    // success handler
                                                      App.alert("alert", "Successfully updated url");
                                               },
                                                   function (transaction, error) {      // error handler
                                                            App.alert("alert", "Could not update the url: " + error.message);
                                                   }
                                               );
                                           }
                                       );

                                    };
                                    cell6.appendChild(t6);

                                    editTable.appendChild(trow);
                                    editTable.appendChild(trow2);

                                    var t6 = document.createElement("button");
                                    t6.id = "btnDoneEdit";
                                    t6.appendChild(document.createTextNode("Finish Editing"));
                                    t6.onclick = function () {
                                        document.getElementById('EventsTable').hidden = false;
                                        //remove self
                                        editTable.parentNode.removeChild(element);
                                    };

                                    document.getElementById('EventsTable').parentElement.appendChild(editTable);
                                    document.getElementById('EventsTable').hidden = true;

                                }
                            },
                            function (transaction, error) {      // error handler
                                App.alert("alert", "Could not edit form: " + error.message);
                            }
                            );
                        });


                }

                //counter to allow editing an event if you del/cancel del/cancel del/cancel
                var editCounter = 0;
                var editID = "";

            function DelEvent(eventID,pType) {
                if (confirm("Are you sure you want to delete event") == false) {
                    
                    if (editCounter == 2 && editID == eventID) {
                        App.alert("alert", "Editing Event!")
                        EditEvent(eventID, pType);
                    }
                    editID = eventID;
                    editCounter++;

                    return;
                }
                editCounter = 0;

                var table = document.getElementById('EventsTable');
                
                for (var i = table.rows.length - 1; i > 0; i--) {
                    table.deleteRow(i);
                }
                var sql = "Delete from Forms where DateTimeID = " + eventID;
                if (!db) {
                    db = openDatabase(dbName, dbVersion, displayName, maxSize);
                }
                if (!db) {
                    App.alert("alert", "Cant open database");
                    return;
                }
                db.transaction(
                    function (transaction) {
                        transaction.executeSql(
                        sql, [], function (transaction, results) {    // success handler
                            ListEvents(pType);
                        },
                        function (transaction, error) {      // error handler
                            App.alert("alert", "Could not delete form: " + error.message);
                        }
                        );
                    });

                    
            }

            function ListEvents(pType) {
                var sql = "SELECT * FROM Forms where Status = " + pType + " order by DateTimeID"; // Not yet submitted or in process
                if (!db) {
                    db = openDatabase(dbName, dbVersion, displayName, maxSize);
                }
                if (!db) {
                    App.alert("alert", "Cant open database");
                    return;
                }
                var table = document.getElementById('EventsTable');
                for (var i = table.rows.length - 1; i > 0; i--) {
                    table.deleteRow(i);
                }
                db.transaction(function (transaction) {
                    transaction.executeSql(sql, [],
                     function (transaction, results) {
                         

                         // Add forms to the table
                         if (results.rows.length == 0) {
                             App.alert("alert", "No events to display");
                         }
                         for (z = 0; z < results.rows.length; z++) {
                             var row = results.rows.item(z);
                             var rowCount = table.rows.length;
                             var trow = table.insertRow(1);
                             var d = new Date(row.DateTimeID);

                             var curr_date = d.getDate();
                             var curr_month = d.getMonth() + 1; //months are zero based
                             var curr_year = d.getFullYear();
                             var curr_hrs = d.getHours();
                             var curr_mins = d.getMinutes();

                             var dString = curr_date + "/" + curr_month + "/" + curr_year + " " + curr_hrs + ":" + curr_mins;

                             var cell1 = trow.insertCell(0);
                             cell1.appendChild(document.createTextNode(dString));

                             var cell2 = trow.insertCell(1);
                             cell2.appendChild(document.createTextNode(row.Title));

                             var cell3 = trow.insertCell(2);
                             cell3.appendChild(document.createTextNode(row.Response));


                             var cell4 = trow.insertCell(3);
                             var element4 = document.createElement('a');
                             element4.setAttribute('href', 'javascript:function');

                             element4.setAttribute('onclick', 'DelEvent(' + row.DateTimeID + ',' + pType + ')');
                             element4.innerText = "Delete";
                             cell4.appendChild(element4);
                             
                         }

                     },
                         function (transaction, error) {
                             App.alert("alert", "Could not list events, database may not yet be initialised " + error.message);
                         });
                });


            }


            function UploadForms() {
                var sql = "SELECT * FROM Forms where Status = 0 or Status = 2 or Status = 3"; // Not yet submitted or in process or failed before
                if (!db) {
                    db = openDatabase(dbName, dbVersion, displayName, maxSize);
                }
                if (!db) {
                    App.alert("alert", "Cant open database");
                    return;
                }
                var z = 0;

                db.transaction(function (transaction) {
                    transaction.executeSql(sql, [],
                     function (transaction, results) {
                         // results.rows holds the rows returned by the query
                         //  App.alert("alert", results.rows.length + " forms left to send to the server");
                         // If any of these are outstanding then we call ourselves again until its all clear
                         for (z = 0; z < results.rows.length; z++) {
                             var row = results.rows.item(z);
                             if (row.Status == 2) {
                                 window.setTimeout(UploadForms, 1000); // Wait 1 secs to try again
                                 return;
                             }
                         }
                         if (results.rows.length > 10) {
                             document.getElementById("Status").style.display = 'block';
                             document.getElementById("Status").firstChild.data = results.rows.length + " events remaining to be uploaded...";
                         }
                         for (z = 0; z < results.rows.length; z++) {
                             
                             var row = results.rows.item(z);
                             var params = row.RequestString;
                             id = row.DateTimeID;
                             // Add the SubmissionID to the querystring to pass up
                             var url = row.Url + "&SubmissionID=" + id;
                             // App.alert("alert", "url is " + url);
                             var http1;
                             var http2;
                             var http3;
                             var http4;
                             var http5;
                             var http6;
                             var http7;
                             var http8;
                             var http9;
                             var http10;

                             if (z == 10) {
                                 window.setTimeout(UploadForms, 1000); // Wait 1 sec to try again
                                 return;
                             }


                             setFormWaiting(id);

                             if (z == 0) {
                                 http1 = new XMLHttpRequest();
                                 http1.open("POST", url, true);

                                 http1.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                 http1.send(params);
                                 http1.onreadystatechange = function () {
                                     if (http1.readyState != 4) {
                                         return;
                                     }
                                     var xmlDoc = http1.responseXML;
                                     return (formResponse(xmlDoc));
                                 };
                             }
                             else if (z == 1) {
                                 http2 = new XMLHttpRequest();
                                 http2.open("POST", url, true);

                                 //Send the proper header information along with the request
                                 http2.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                 http2.send(params);
                                 http2.onreadystatechange = function () {
                                     if (http2.readyState != 4) {
                                         return;
                                     }
                                     var xmlDoc2 = http2.responseXML;
                                     return (formResponse(xmlDoc2));
                                 };
                             }
                             else if (z == 2) {
                                 http3 = new XMLHttpRequest();
                                 http3.open("POST", url, true);

                                 //Send the proper header information along with the request
                                 http3.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                 http3.send(params);
                                 http3.onreadystatechange = function () {
                                     if (http3.readyState != 4) {
                                         return;
                                     }
                                     var xmlDoc3 = http3.responseXML;
                                     return (formResponse(xmlDoc3));
                                 };
                             }
                             else if (z == 3) {
                                 http4 = new XMLHttpRequest();
                                 http4.open("POST", url, true);

                                 //Send the proper header information along with the request
                                 http4.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                 http4.send(params);
                                 http4.onreadystatechange = function () {
                                     if (http4.readyState != 4) {
                                         return;
                                     }
                                     var xmlDoc4 = http4.responseXML;
                                     return (formResponse(xmlDoc4));
                                 };
                             }
                             else if (z == 4) {
                                 http5 = new XMLHttpRequest();
                                 http5.open("POST", url, true);

                                 //Send the proper header information along with the request
                                 http5.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                 http5.send(params);
                                 http5.onreadystatechange = function () {
                                     if (http5.readyState != 4) {
                                         return;
                                     }
                                     var xmlDoc5 = http5.responseXML;
                                     return (formResponse(xmlDoc5));
                                 };
                             }
                             else if (z == 5) {
                                 http6 = new XMLHttpRequest();
                                 http6.open("POST", url, true);

                                 //Send the proper header information along with the request
                                 http6.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                 http6.send(params);
                                 http6.onreadystatechange = function () {
                                     if (http6.readyState != 4) {
                                         return;
                                     }
                                     var xmlDoc6 = http6.responseXML;
                                     return (formResponse(xmlDoc6));
                                 };
                             }
                             else if (z == 6) {
                                 http7 = new XMLHttpRequest();
                                 http7.open("POST", url, true);

                                 //Send the proper header information along with the request
                                 http7.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                 http7.send(params);
                                 http7.onreadystatechange = function () {
                                     if (http7.readyState != 4) {
                                         return;
                                     }
                                     var xmlDoc7 = http7.responseXML;
                                     return (formResponse(xmlDoc7));
                                 };
                             }
                             else if (z == 7) {
                                 http8 = new XMLHttpRequest();
                                 http8.open("POST", url, true);

                                 //Send the proper header information along with the request
                                 http8.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                 http8.send(params);
                                 http8.onreadystatechange = function () {
                                     if (http8.readyState != 4) {
                                         return;
                                     }
                                     var xmlDoc8 = http8.responseXML;
                                     return (formResponse(xmlDoc8));
                                 };
                             }
                             else if (z == 8) {
                                 http9 = new XMLHttpRequest();
                                 http9.open("POST", url, true);

                                 //Send the proper header information along with the request
                                 http9.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                 http9.send(params);
                                 http9.onreadystatechange = function () {
                                     if (http9.readyState != 4) {
                                         return;
                                     }
                                     var xmlDoc9 = http9.responseXML;
                                     return (formResponse(xmlDoc9));
                                 };
                             }
                             else if (z == 9) {
                                 http10 = new XMLHttpRequest();
                                 http10.open("POST", url, true);

                                 //Send the proper header information along with the request
                                 http10.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
                                 http10.send(params);
                                 http10.onreadystatechange = function () {
                                     if (http10.readyState != 4) {
                                         return;
                                     }
                                     var xmlDoc10 = http10.responseXML;
                                     return (formResponse(xmlDoc10));
                                 };
                             }
                             if (z == results.rows.length - 1) {
                                 App.alert("alert", "All events submitted.");
                             }


                         }

                     },
                         function (transaction, error) {
                             //    App.alert("alert", "Could not read: " + error.message);
                         });
                });
                   


                 }
                 function TestLink() {
                     App.alert("alert", "link tested");
                 }
                 
                 function ResetForms() {
                     var db = openDatabase(dbName, dbVersion, displayName, maxSize);
                     if (!db) {
                         App.alert("alert", "Cant open database");
                         return;
                     }
                     // As part of the initialisation process we also set any semi uploaded forms to being fresh for upload
                     db.transaction(
                            function (transaction) {
                                transaction.executeSql(
                                'Update Forms set Status = 0 where Status = 2',
                                [], function (transaction, results) {    // success handler
                                    //   App.alert("alert", "Successfully created forms table");
                                },
                                    function (transaction, error) {      // error handler
                                   //     App.alert("alert", "Could not reset the statuses for the outstanding forms: " + error.message);
                                    }
                                );
                            }
                        );
                 }

        
        
        function InitialiseCowDatabase() {

            var db = openDatabase(dbName, dbVersion, displayName, maxSize);
            if (!db) {
                App.alert("alert", "Cant open database");
                return;
            }

            // Drop and recreate the Cows and DynamicsLists table
            db.transaction(
                function (transaction) {
                    transaction.executeSql(
                    'DROP TABLE IF EXISTS Cows;', [], function (transaction, results) {    // success handler
                       // App.alert("alert", "Successfully created table");
                       },
                        function (transaction, error) {      // error handler
                               App.alert("alert", "Could not drop Cow table: " + error.message);
                           }
                    );
                }
            );
            
            db.transaction(
                function (transaction) {
                    transaction.executeSql(
                    'CREATE TABLE Cows ' +
                    '  (NationalID TEXT NOT NULL, ' +
                    '   InternalAnimalID TEXT NOT NULL, FreezeBrand TEXT , FreezeBrandNo INTEGER , PurchasedFrom TEXT, Sire TEXT,' +
                    '   BreedText TEXT, DateOfBirth TEXT , JoinDate Text , ElectronicID INTEGER,NFCID INTEGER, NotesString TEXT, [Group] TEXT,' +
                    '   BreedHistoryText TEXT, SexText TEXT , LastServedDate TEXT, LastCalvedDate TEXT, LastServedTo TEXT, ' +
                    ' TreatmentText TEXT,Fqas TEXT,MilkRecordsText TEXT,Age INTEGER,InBreedingPotential TEXT,InternalHerdID INTEGER,BoughtPrice TEXT,WeightHistoryText TEXT,DLWG TEXT,Dam TEXT, ' +
                        ' LastWeight TEXT,LastWeightDate TEXT,CurrentLactation TEXT,CurrentStatus TEXT,Alert TEXT,Exception TEXT,ScoreHistory TEXT,WithdrawalDate TEXT);', [], function (transaction, results) {    // success handler
                        // App.alert("alert", "Successfully created table");
                    },
                        function (transaction, error) {      // error handler
                            App.alert("alert", "Could not create cow table: " + error.message);
                        }
                    );
                }
            );

           // Create the database to maintain the offline forms
           // this one is only flushed as forms are written
            db.transaction(
                function (transaction) {
                    transaction.executeSql(
                    'CREATE TABLE IF NOT EXISTS Forms ' +
                    '  (DateTimeID REAL NOT NULL PRIMARY KEY, ' +
                    '   RequestString TEXT NOT NULL, Status INTEGER NOT NULL , Url TEXT, Response TEXT, Title TEXT);', 
                    [], function (transaction, results) {    // success handler
                         //   App.alert("alert", "Successfully created forms table");
                        },
                        function (transaction, error) {      // error handler
                           App.alert("alert", "Could not create forms table: " + error.message);
                        }
                    );
                }
            );

         
            return(db);
        }

        function InitialiseListDatabase() {

            var db = openDatabase(dbName, dbVersion, displayName, maxSize);
            if (!db) {
                App.alert("alert", "Cant open database");
                return;
            }

            db.transaction(
                function (transaction) {
                    transaction.executeSql(
                    'DROP TABLE IF EXISTS DynamicLists;', [], function (transaction, results) {    // success handler
                        // App.alert("alert", "Successfully created table");
                    },
                        function (transaction, error) {      // error handler
                            App.alert("alert", "Could not drop Dynamic list tables: " + error.message);
                        }
                    );
                }
            );


            db.transaction(
                function (transaction) {
                    transaction.executeSql(
                    'CREATE TABLE DynamicLists ' +
                    '  (HerdID INTEGER NOT NULL, ' +
                    '   ListName TEXT NOT NULL, Name TEXT NOT NULL , Value TEXT NOT NULL, IsBreeding INTEGER);', [], function (transaction, results) {    // success handler
                        // App.alert("alert", "Successfully created table");
                    },
                           function (transaction, error) {      // error handler
                               App.alert("alert", "Could not create dynamic list table: " + error.message);
                           }
                    );
                }
            );

            return (db);
        }           

        

        // Need this in case a value is null just return a space
        function getItemValue(pItem) {
            var value = "";
            if (pItem != null) {
                value = pItem.value;
            }
            return (value);
        }

        function timeoutFired() {
            App.alert("alert", "Database update attempt timed out");
        }


        var maxHerdIndex;
        var currentHerdDatabaseIndex;
        var currentHerdListIndex;

        function LoadSpecificHerdList(herdID, listDb, name) {
            // These are specific to the DynamicLists table
            var listNameArray = [];
            var internalHerdIDArray = [];
              
            var nameArray = [];
            var valueArray = [];
            var isBreedingArray = [];
            var eventArray = [];
            var nrrArray = [];
            var d = new Date();
              
            
            /*
            * Make the call to download the dynamic list data
            */
            document.getElementById("Status").style.display = 'block';
			document.getElementById("Status").firstChild.data = "Downloading lists and reports for " + name + "....";
              
            xmlhttp2 = new XMLHttpRequest();
			
            url = "mobile/mgenxml.aspx?Type=DynamicLists&TimeStamp=" + d.getTime() + "&HerdID=" + herdID;
            xmlhttp2.open("GET", url, true);
            xmlhttp2.send();
            xmlhttp2.onreadystatechange = function () {
                if (xmlhttp2.readyState == 4) {
                    var xmlDoc = xmlhttp2.responseXML;

                    if (xmlDoc == null) {
                        App.alert("alert", "Cant get dynamic list data please try again:" + xmlhttp2.responseText);
                        if (xmlhttp2.responseText.indexOf("Your security") >= 0) {
                            window.location.href = "ilogin.aspx";
                        }
                        return;
                    }
                   
                    x = xmlDoc.getElementsByTagName("DynamicList");

                    for (var i = 0; i < x.length; i++) {
                        internalHerdIDArray[i] = getItemValue(x[i].attributes.getNamedItem("HerdID"));
                        listNameArray[i] = getItemValue(x[i].attributes.getNamedItem("ListName"));
                        nameArray[i] = getItemValue(x[i].attributes.getNamedItem("Name"));
                        valueArray[i] = getItemValue(x[i].attributes.getNamedItem("Value"));
                        isBreedingArray[i] = getItemValue(x[i].attributes.getNamedItem("IsBreeding"));
                        eventArray[i] = getItemValue(x[i].attributes.getNamedItem("RecentEventList"));
                        nrrArray[i] = getItemValue(x[i].attributes.getNamedItem("NrrValue"));
                    }
                    
                    listDb.transaction(function (transaction) {
                        for (var i = 0; i < internalHerdIDArray.length; i++) {
                            var sql = "INSERT INTO 'DynamicLists' (HerdID,ListName,Name,Value,IsBreeding)" +
                                " VALUES (?,?,?,?,?)";
                            transaction.executeSql(sql, [internalHerdIDArray[i], listNameArray[i], nameArray[i], valueArray[i],
                                            isBreedingArray[i]],
                           function (transaction, results) {    // success handler
                               // App.alert("alert", "Successfully inserted record");
                           },
                           function (transaction, error) {      // error handler
                               App.alert("alert", "Could not insert record: " + error.message);
                           }
                        );
                        }
                    });
                   currentHerdListIndex += 1;
                   if ((currentHerdListIndex == maxHerdIndex) && (currentHerdDatabaseIndex == maxHerdIndex)) {
                       document.getElementById("Buttons").style.display = 'block';
                       document.getElementById("Status").style.display = 'block';
                       document.getElementById("Status").firstChild.data = "Loaded data for " + currentHerdListIndex + " herds";
                          
                       App.message("Loaded data for " + currentHerdListIndex + " herds");

                       setHerdID();

					   $(".progress").fadeOut("slow", null);
                   }
                   if (currentHerdListIndex < maxHerdIndex) {
                       var s = document.getElementById("MultiHerd");
                       LoadSpecificHerdList(s.options[currentHerdListIndex].value, listDb, s.options[currentHerdListIndex].text);
                   }

                }
            };
              
        }

        function LoadSpecificHerdDatabase(herdID,cowDb,name) {
              var nationalIDArray = [];
              var internalAnimalIDArray = [];
              var freezeBrandArray = [];
              var freezeBrandNoArray = [];
              var breedTextArray = [];
              var dateOfBirthArray = [];
              var joinDateArray = [];
              var breedHistoryTextArray = [];
              var sexTextArray = [];
              var treatmentTextArray = [];

              var electronicIDArray = [];
              var nfcIDArray = [];
              var groupArray = [];
              var notesStringArray = [];
              var lastServedDateArray = [];
              var lastCalvedDateArray = [];
              var lastServedToArray = [];
              var purchasedFromArray = [];
              var sireArray = [];
              var fqasArray = [];
              var milkRecordsTextArray = [];
              var ageArray = [];
              var inBreedingPotentialArray = [];
              var internalHerdIDArray = [];
              var boughtPriceArray = [];
              var weightHistoryTextArray = [];
              var dlwgArray = [];
              var damArray = [];
              var lastWeightArray = [];
              var lastWeightDateArray = [];
              var currentLactationArray = [];
              var currentStatusArray = [];
			  
			  var alertArray = [];
              var exceptionArray = [];
              var scoreHistoryArray = [];
              var withdrawalDateArray=[];



              xmlhttp = new XMLHttpRequest();
              xmlhttp.readyState = 0;
              xmlhttp.timeout = 800000;
              xmlhttp.ontimeout = timeoutFired;

              var prevMessage = document.getElementById("Status").firstChild.data;

              document.getElementById("Status").style.display = 'block';
              document.getElementById("Status").firstChild.data = "Downloading animals for " + name + "....";
              
              var d = new Date();
              var url = "mobile/mgenxml.aspx?Type=DairyBeef&TimeStamp=" + d.getTime() + "&HerdID=" + herdID;
              xmlhttp.open("GET", url, true);
              xmlhttp.send();
              xmlhttp.onreadystatechange = function () {
                  if (xmlhttp.readyState == 4) {
                      var xmlDoc = xmlhttp.responseXML;

                      if (xmlDoc == null) {
                          // Keep retrying
                          //window.setTimeout(LoadMobileDatabase, 1000); // Wait 1 secs to try again
                          App.alert("alert", "Cant get updated data please try again:" + xmlhttp.responseText);
                          //document.getElementById("Status").firstChild.data = prevMessage;
                          //document.getElementById("Buttons").style.display = 'block';
                          return;
                      }

                      x = xmlDoc.getElementsByTagName("Cow");

                      for (var i = 0; i < x.length; i++) {
                          nationalIDArray[i] = getItemValue(x[i].attributes.getNamedItem("NationalID"));
                          internalAnimalIDArray[i] = getItemValue(x[i].attributes.getNamedItem("InternalAnimalID"));
                          freezeBrandArray[i] = getItemValue(x[i].attributes.getNamedItem("FreezeBrand"));
                          freezeBrandNoArray[i] = getItemValue(x[i].attributes.getNamedItem("FreezeBrandNo"));
                          breedTextArray[i] = getItemValue(x[i].attributes.getNamedItem("BreedText"));
                          dateOfBirthArray[i] = getItemValue(x[i].attributes.getNamedItem("DateOfBirth"));
                          joinDateArray[i] = getItemValue(x[i].attributes.getNamedItem("JoinDate"));
                          breedHistoryTextArray[i] = getItemValue(x[i].attributes.getNamedItem("BreedHistoryText"));
                          sexTextArray[i] = getItemValue(x[i].attributes.getNamedItem("SexText"));
                          joinDateArray[i] = getItemValue(x[i].attributes.getNamedItem("JoinDate"));
                          treatmentTextArray[i] = getItemValue(x[i].attributes.getNamedItem("TreatmentText"));

                          electronicIDArray[i] = getItemValue(x[i].attributes.getNamedItem("ElectronicID"));
                          nfcIDArray[i] = getItemValue(x[i].attributes.getNamedItem("NFCID"));
                          groupArray[i] = getItemValue(x[i].attributes.getNamedItem("Group"));
                          notesStringArray[i] = getItemValue(x[i].attributes.getNamedItem("NotesString"));
                          lastServedDateArray[i] = getItemValue(x[i].attributes.getNamedItem("LastServedDate"));
                          lastCalvedDateArray[i] = getItemValue(x[i].attributes.getNamedItem("LastCalvedDate"));
                          lastServedToArray[i] = getItemValue(x[i].attributes.getNamedItem("LastServedTo"));
                          purchasedFromArray[i] = getItemValue(x[i].attributes.getNamedItem("PurchasedFrom"));
                          sireArray[i] = getItemValue(x[i].attributes.getNamedItem("Sire"));
                          fqasArray[i] = getItemValue(x[i].attributes.getNamedItem("Fqas"));
                          milkRecordsTextArray[i] = getItemValue(x[i].attributes.getNamedItem("MilkRecordsText"));
                          ageArray[i] = getItemValue(x[i].attributes.getNamedItem("Age"));
                          inBreedingPotentialArray[i] = getItemValue(x[i].attributes.getNamedItem("InBreedingPotential"));
                          internalHerdIDArray[i] = getItemValue(x[i].attributes.getNamedItem("InternalHerdID"));

                          boughtPriceArray[i] = getItemValue(x[i].attributes.getNamedItem("BoughtPrice"));
                          weightHistoryTextArray[i] = getItemValue(x[i].attributes.getNamedItem("WeightHistoryText"));
                          dlwgArray[i] = getItemValue(x[i].attributes.getNamedItem("DLWG"));
                          damArray[i] = getItemValue(x[i].attributes.getNamedItem("Dam"));

                          lastWeightArray[i] = getItemValue(x[i].attributes.getNamedItem("LastWeight"));
                          lastWeightDateArray[i] = getItemValue(x[i].attributes.getNamedItem("LastWeightDate"));

                          currentLactationArray[i] = getItemValue(x[i].attributes.getNamedItem("CurrentLactation"));
                          currentStatusArray[i] = getItemValue(x[i].attributes.getNamedItem("CurrentStatus"));
						  
						  alertArray[i] = getItemValue(x[i].attributes.getNamedItem("Alert"));
						  exceptionArray[i] = getItemValue(x[i].attributes.getNamedItem("Exception"));
						  
						  scoreHistoryArray[i] = getItemValue(x[i].attributes.getNamedItem("ScoreHistory"));
						  withdrawalDateArray[i] = getItemValue(x[i].attributes.getNamedItem("WithdrawalDate"));


                      }

                      cowDb.transaction(function (transaction) {
                          for (var i = 0; i < freezeBrandArray.length; i++) {
                              var sql = "INSERT INTO 'Cows' (NationalID,InternalAnimalID,FreezeBrand,FreezeBrandNo,BreedText,DateOfBirth," +
                              "JoinDate,BreedHistoryText,SexText,JoinDate,TreatmentText,ElectronicID, NFCID,[Group],NotesString,LastServedDate,LastCalvedDate," +
                                "LastServedTo,PurchasedFrom,Sire,Fqas,MilkRecordsText,Age,InBreedingPotential,InternalHerdID,BoughtPrice,WeightHistoryText,DLWG,Dam," +
                                    "lastWeight,lastWeightDate,CurrentLactation,CurrentStatus,Alert,Exception,ScoreHistory,WithdrawalDate) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                              transaction.executeSql(sql, [nationalIDArray[i], internalAnimalIDArray[i], freezeBrandArray[i],
                       freezeBrandNoArray[i], breedTextArray[i], dateOfBirthArray[i], joinDateArray[i], breedHistoryTextArray[i],
                          sexTextArray[i], joinDateArray[i], treatmentTextArray[i], electronicIDArray[i],nfcIDArray[i], groupArray[i], notesStringArray[i],
                        lastServedDateArray[i], lastCalvedDateArray[i], lastServedToArray[i], purchasedFromArray[i], sireArray[i], fqasArray[i],
                        milkRecordsTextArray[i], ageArray[i], inBreedingPotentialArray[i], internalHerdIDArray[i], boughtPriceArray[i], weightHistoryTextArray[i], dlwgArray[i],
                                    damArray[i], lastWeightArray[i], lastWeightDateArray[i], currentLactationArray[i], currentStatusArray[i],alertArray[i],exceptionArray[i],scoreHistoryArray[i],withdrawalDateArray[i]],
                            function (transaction, results) {    // success handler
                                // App.alert("alert", "Successfully inserted record");
                            },
                           function (transaction, error) {      // error handler
                               App.alert("alert", "Could not insert record: " + error.message);
                           }
                     );
                          }
                      });
                      currentHerdDatabaseIndex += 1;
                      if ((currentHerdListIndex == maxHerdIndex) && (currentHerdDatabaseIndex == maxHerdIndex)) {
						  //document.getElementById("Status").firstChild.data = "Select herd to continue";
                          document.getElementById("Buttons").style.display = 'block';
                          App.alert("alert", "Loaded data for " + currentHerdListIndex + " herds");
                      }
                      if (currentHerdDatabaseIndex < maxHerdIndex) {
                          var s = document.getElementById("MultiHerd");
                          LoadSpecificHerdDatabase(s.options[currentHerdDatabaseIndex].value, cowDb, s.options[currentHerdDatabaseIndex].text);
                      }
					  // Start the calls to get the dynamic lists down once we have the herds all got down
					  else {
					      document.getElementById("Buttons").style.display = 'none';
						  currentHerdListIndex = 0;
						  var s = document.getElementById("MultiHerd");
						  var listDb = InitialiseListDatabase();
                   
						  LoadSpecificHerdList(s.options[currentHerdListIndex].value, listDb, s.options[currentHerdListIndex].text);
					  }

                  }
              };


              

        }


        function LoadMobileDatabase(callback) {

               var s = document.getElementById("MultiHerd");
               if (s) {
                   var cowDb = InitialiseCowDatabase();

                   maxHerdIndex = s.options.length;
                   currentHerdDatabaseIndex = 0;
                   currentHerdListIndex = 0;
                   LoadSpecificHerdDatabase(s.options[currentHerdDatabaseIndex].value, cowDb, s.options[currentHerdDatabaseIndex].text);
                  // Change this to after the herd comes down
				  // LoadSpecificHerdList(s.options[currentHerdListIndex].value, listDb, s.options[currentHerdListIndex].text);
                   
                   return;
                }

              var nationalIDArray = [];
              var internalAnimalIDArray = [];
              var freezeBrandArray = [];
              var freezeBrandNoArray = [];
              var breedTextArray = [];
              var dateOfBirthArray = [];
              var joinDateArray = [];
              var breedHistoryTextArray = [];
              var sexTextArray = [];
              var treatmentTextArray = [];

              var electronicIDArray = [];
              var nfcIDArray = [];
              var groupArray = [];
              var notesStringArray = [];
              var lastServedDateArray = [];
              var lastCalvedDateArray = [];
              var lastServedToArray = [];
              var purchasedFromArray = [];
              var sireArray = [];
              var fqasArray = [];
              var milkRecordsTextArray = [];
              var ageArray = [];
              var inBreedingPotentialArray = [];
              var internalHerdIDArray = [];
              var boughtPriceArray = [];
              var weightHistoryTextArray = [];
              var dlwgArray = [];
              var damArray = [];
              var lastWeightArray = [];
              var lastWeightDateArray = [];
              var currentLactationArray = [];
              var currentStatusArray = [];
			  var alertArray = [];
              var exceptionArray = [];
              var scoreHistoryArray = [];
              var withdrawalDateArray = [];

              // These are specific to the DynamicLists table
              var listNameArray = [];
              var nameArray = [];
              var valueArray = [];
              var isBreedingArray = [];
              var eventArray = [];
              var nrrArray = [];


              //
              var databaseLoaded = false;
              var listsLoaded = false;

              outstandingDownload = 0;

              xmlhttp = new XMLHttpRequest();
              xmlhttp.readyState = 0;
              xmlhttp.timeout = 800000;
              xmlhttp.ontimeout = timeoutFired;

              var prevMessage = document.getElementById("Status").firstChild.data;

              document.getElementById("Status").style.display = 'block';
              document.getElementById("Status").firstChild.data = "Synchronising with Online database please wait...";
              
              var d = new Date();
              var url = "mobile/mgenxml.aspx?Type=DairyBeef&TimeStamp=" + d.getTime();
              xmlhttp.open("GET", url, true);
              outstandingDownload += 1;
              xmlhttp.send();
              xmlhttp.onreadystatechange = function () {
                  if (xmlhttp.readyState == 4) {
                      var xmlDoc = xmlhttp.responseXML;

                      if (xmlDoc == null) {
                          // Keep retrying
                          //window.setTimeout(LoadMobileDatabase, 1000); // Wait 1 secs to try again
                          App.alert("alert", "Cant get updated data please try again:" + xmlhttp.responseText);
                          //document.getElementById("Status").firstChild.data = prevMessage;
                          //document.getElementById("Buttons").style.display = 'block';
                          return;
                      }
                      var db = InitialiseCowDatabase();

                      App.alert("alert", "Database updated");
                      databaseLoaded = true;
                      if (databaseLoaded && listsLoaded)
                      {
                          if (callback)
                              callback();
                      }

                      x = xmlDoc.getElementsByTagName("Cow");

                      for (var i = 0; i < x.length; i++) {
                          nationalIDArray[i] = getItemValue(x[i].attributes.getNamedItem("NationalID"));
                          internalAnimalIDArray[i] = getItemValue(x[i].attributes.getNamedItem("InternalAnimalID"));
                          freezeBrandArray[i] = getItemValue(x[i].attributes.getNamedItem("FreezeBrand"));
                          freezeBrandNoArray[i] = getItemValue(x[i].attributes.getNamedItem("FreezeBrandNo"));
                          breedTextArray[i] = getItemValue(x[i].attributes.getNamedItem("BreedText"));
                          dateOfBirthArray[i] = getItemValue(x[i].attributes.getNamedItem("DateOfBirth"));
                          joinDateArray[i] = getItemValue(x[i].attributes.getNamedItem("JoinDate"));
                          breedHistoryTextArray[i] = getItemValue(x[i].attributes.getNamedItem("BreedHistoryText"));
                          sexTextArray[i] = getItemValue(x[i].attributes.getNamedItem("SexText"));
                          joinDateArray[i] = getItemValue(x[i].attributes.getNamedItem("JoinDate"));
                          treatmentTextArray[i] = getItemValue(x[i].attributes.getNamedItem("TreatmentText"));

                          electronicIDArray[i] = getItemValue(x[i].attributes.getNamedItem("ElectronicID"));
                          nfcIDArray[i] = getItemValue(x[i].attributes.getNamedItem("NFCID"));
                          groupArray[i] = getItemValue(x[i].attributes.getNamedItem("Group"));
                          notesStringArray[i] = getItemValue(x[i].attributes.getNamedItem("NotesString"));
                          lastServedDateArray[i] = getItemValue(x[i].attributes.getNamedItem("LastServedDate"));
                          lastCalvedDateArray[i] = getItemValue(x[i].attributes.getNamedItem("LastCalvedDate"));
                          lastServedToArray[i] = getItemValue(x[i].attributes.getNamedItem("LastServedTo"));
                          purchasedFromArray[i] = getItemValue(x[i].attributes.getNamedItem("PurchasedFrom"));
                          sireArray[i] = getItemValue(x[i].attributes.getNamedItem("Sire"));
                          fqasArray[i] = getItemValue(x[i].attributes.getNamedItem("Fqas"));
                          milkRecordsTextArray[i] = getItemValue(x[i].attributes.getNamedItem("MilkRecordsText"));
                          ageArray[i] = getItemValue(x[i].attributes.getNamedItem("Age"));
                          inBreedingPotentialArray[i] = getItemValue(x[i].attributes.getNamedItem("InBreedingPotential"));
                          internalHerdIDArray[i] = getItemValue(x[i].attributes.getNamedItem("InternalHerdID"));

                          boughtPriceArray[i] = getItemValue(x[i].attributes.getNamedItem("BoughtPrice"));
                          weightHistoryTextArray[i] = getItemValue(x[i].attributes.getNamedItem("WeightHistoryText"));
                          dlwgArray[i] = getItemValue(x[i].attributes.getNamedItem("DLWG"));
                          damArray[i] = getItemValue(x[i].attributes.getNamedItem("Dam"));

                          lastWeightArray[i] = getItemValue(x[i].attributes.getNamedItem("LastWeight"));
                          lastWeightDateArray[i] = getItemValue(x[i].attributes.getNamedItem("LastWeightDate"));

                          currentLactationArray[i] = getItemValue(x[i].attributes.getNamedItem("CurrentLactation"));
                          currentStatusArray[i] = getItemValue(x[i].attributes.getNamedItem("CurrentStatus"));
						  
						  alertArray[i] = getItemValue(x[i].attributes.getNamedItem("Alert"));
						  exceptionArray[i] = getItemValue(x[i].attributes.getNamedItem("Exception"));
						  scoreHistoryArray[i] = getItemValue(x[i].attributes.getNamedItem("ScoreHistory"));
						  withdrawalDateArray[i] = getItemValue(x[i].attributes.getNamedItem("WithdrawalDate"));

                      }

                      db.transaction(function (transaction) {
                          for (var i = 0; i < freezeBrandArray.length; i++) {
                              var sql = "INSERT INTO 'Cows' (NationalID,InternalAnimalID,FreezeBrand,FreezeBrandNo,BreedText,DateOfBirth," +
                              "JoinDate,BreedHistoryText,SexText,JoinDate,TreatmentText,ElectronicID,NFCID,[Group],NotesString,LastServedDate,LastCalvedDate," +
                                "LastServedTo,PurchasedFrom,Sire,Fqas,MilkRecordsText,Age,InBreedingPotential,InternalHerdID,BoughtPrice,WeightHistoryText,DLWG,Dam," +
                                    "lastWeight,lastWeightDate,CurrentLactation,CurrentStatus,Alert,Exception,ScoreHistory,WithdrawalDate) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                              transaction.executeSql(sql, [nationalIDArray[i], internalAnimalIDArray[i], freezeBrandArray[i],
                       freezeBrandNoArray[i], breedTextArray[i], dateOfBirthArray[i], joinDateArray[i], breedHistoryTextArray[i],
                          sexTextArray[i], joinDateArray[i], treatmentTextArray[i], electronicIDArray[i],nfcIDArray[i], groupArray[i], notesStringArray[i],
                        lastServedDateArray[i], lastCalvedDateArray[i], lastServedToArray[i], purchasedFromArray[i], sireArray[i], fqasArray[i],
                        milkRecordsTextArray[i], ageArray[i], inBreedingPotentialArray[i], internalHerdIDArray[i], boughtPriceArray[i], weightHistoryTextArray[i], dlwgArray[i],
                                    damArray[i], lastWeightArray[i], lastWeightDateArray[i], currentLactationArray[i], currentStatusArray[i],alertArray[i],exceptionArray[i],scoreHistoryArray[i],withdrawalDateArray[i]],
                            function (transaction, results) {    // success handler
                                // App.alert("alert", "Successfully inserted record");
                            },
                           function (transaction, error) {      // error handler
                               App.alert("alert", "Could not insert record: " + error.message);
                           }
                     );
                          }
                      });
                      //document.getElementById("Status").firstChild.data = x.length + " animals loaded";

                      changeSearchPlaceHolder("Search " + x.length + " Animals");

                      $(".progress").fadeOut("slow", null);

		      // Get Dynamic lists
		/*
              * Make the call to download the dynamic list data
              */
              xmlhttp2 = new XMLHttpRequest();

              url = "mobile/mgenxml.aspx?Type=DynamicLists&TimeStamp=" + d.getTime();
              xmlhttp2.open("GET", url, true);
              xmlhttp2.send();
              outstandingDownload += 1;
              xmlhttp2.onreadystatechange = function () {
                  if (xmlhttp2.readyState == 4) {
                      var xmlDoc = xmlhttp2.responseXML;

                      if (xmlDoc == null) {
                          App.alert("alert", "Cant get dynamic list data please try again:" + xmlhttp2.responseText);
                          if (xmlhttp2.responseText.indexOf("Your security") >= 0) {
                                window.location.href= "ilogin.aspx";
                          }
                          return;
                      }
                      App.alert("alert", "Loaded data entry lists");
                      listsLoaded = true;
                      if (databaseLoaded && listsLoaded) {
                          if(callback)
                          callback();
                      }

                      x = xmlDoc.getElementsByTagName("DynamicList");

                      for (var i = 0; i < x.length; i++) {
                          internalHerdIDArray[i] = getItemValue(x[i].attributes.getNamedItem("HerdID"));
                          listNameArray[i] = getItemValue(x[i].attributes.getNamedItem("ListName"));
                          nameArray[i] = getItemValue(x[i].attributes.getNamedItem("Name"));
                          valueArray[i] = getItemValue(x[i].attributes.getNamedItem("Value"));
                          isBreedingArray[i] = getItemValue(x[i].attributes.getNamedItem("IsBreeding"));
                          eventArray[i] = getItemValue(x[i].attributes.getNamedItem("RecentEventList"));
                          nrrArray[i] = getItemValue(x[i].attributes.getNamedItem("NrrValue"));
                      }
                      var db = InitialiseListDatabase();
                      document.getElementById("Buttons").style.display = 'block';
                      
                      db.transaction(function (transaction) {
                          for (var i = 0; i < internalHerdIDArray.length; i++) {
                              var sql = "INSERT INTO 'DynamicLists' (HerdID,ListName,Name,Value,IsBreeding)" +
                                " VALUES (?,?,?,?,?)";
                              transaction.executeSql(sql, [internalHerdIDArray[i], listNameArray[i], nameArray[i], valueArray[i],
                                            isBreedingArray[i]],
                           function (transaction, results) {    // success handler
                               // App.alert("alert", "Successfully inserted record");

                           },
                           function (transaction, error) {      // error handler
                               App.alert("alert", "Could not insert record: " + error.message);
                           }
                        );
                          }

                      });



                  }
              };



                  }
              };


                            
          }