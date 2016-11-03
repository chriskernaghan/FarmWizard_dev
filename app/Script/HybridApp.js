/**
* Requires JQuery 
*/
function App() {
}

var standalone = window.navigator.standalone,
    userAgent = window.navigator.userAgent.toLowerCase(),
    ios = /safari/.test(userAgent),
    ios_app = /iphone|ipod|ipad/.test(userAgent),
    android = /android/.test(userAgent),
    android_app = /farmwizard.android\/[0-9\.]+$/.test(userAgent);

App.androidApp = function () {
    return android_app;
}

App.androidBrowser = function () {
    return android;
}

App.iOSApp = function () {
    return ios_app;
}

App.iOSBrowser = function () {
    return ios;
}

/**
 * Shows an alert dialog on the app.
 *
 * @param {text} title The desired title of the alert.
 * @param {text} message The desired message of the alert.
 */
App.alert = function (title, message) {
    if (android_app)
        AndroidJS.Alert(title, message);
    else if (ios_app)
        location.href = "hybrid:alert?title=" + title + "&message=" + message;
    else {
        $("<div title='" + title + "'><p>" + message + "</p></div>").dialog({
            resizable: false,
            height: "auto",
            modal: true,
            buttons: {
                OK: function () {
                    $(this).dialog("close");
                    $(this).dialog("destroy").remove()
                }
            }
        });
    }
    return false;
}

/**
 * Shows a confirm dialog on the app.
 *
 * @param {text} title The desired title of the confirm.
 * @param {text} message The desired message of the confirm.
 * @param {text} callback The name of the function to callback to, should be like "functionName(id, value)"
 * @param {text} id The identifier to send back in the callback - eg. "functionName(1234, value)"
 */
App.confirm = function (title, message, callback, id) {
    if (android_app)
        AndroidJS.Confirm(title, message, callback, id);
    else if (ios_app)
        location.href = "hybrid:confirm?title=" + title + "&message=" + message + "&callback=" + callback + "&id=" + id;
    else {
        $("<div title='" + title + "'><p>" + message + "</p></div>").dialog({
            resizable: false,
            height: "auto",
            modal: true,
            buttons: {
                OK: function () {
                    if (typeof (window[callback]) == "function")
                        window[callback](id, true);
                    $(this).dialog("close");
                    $(this).dialog("destroy").remove()
                },
                Cancel: function () {
                    if (typeof (window[callback]) == "function")
                        window[callback](id, false);
                    $(this).dialog("close");
                    $(this).dialog("destroy").remove()
                }
            }
        });
    }
    return false;
}

/**
 * Shows a toast/message on the app.
 *
 * @param {text} message The desired message of the message.
 */
App.message = function (message) {
    if (android_app)
        AndroidJS.Message(message);
    else if (ios_app)
        location.href = "hybrid:message?message=" + message;
    else {
        toastr.info("'" + message + "'");
    }

    return false;
}

/**
 * Shows a text input dialog on the app.
 *
 * @param {text} title The desired title of the confirm.
 * @param {text} message The desired message of the confirm.
 * @param {text} callback The name of the function to callback to, should be like "functionName(id, value)"
 * @param {text} id The identifier to send back in the callback - eg. "functionName(1234, value)"
 */
App.textInput = function (title, message, callback, id, numeric) {
    if (android_app)
        AndroidJS.TextInput(title, message, callback, id, numeric);
    else if (ios_app)
        location.href = "hybrid:textinput?title=" + title + "&message=" + message + "&callback=" + callback + "&id=" + id;
    else {
        //show a text input jquery 
        var inputType = "text";
        if (numeric)
            inputType = "number";

        $("<div title='" + title + "'><p>" + message + "</p><form><input type='" + inputType + "' name='name' id='popUpTxtVal' /></form></div>").dialog({
            modal: true,
            buttons: {
                OK: function () {
                    var textVal = $("#popUpTxtVal");
                    if (typeof (window[callback]) == "function")
                        window[callback](id, textVal.val());
                    $(this).dialog("close");
                    $(this).dialog("destroy").remove()
                },
                Cancel: function () {
                    if (typeof (window[callback]) == "function")
                        window[callback](id, false);
                    $(this).dialog("close");
                    $(this).dialog("destroy").remove()
                }
            }
        });
    }
    return false;
}

/**
 * Shows a select dialog - note on android the message is ignored.
 *
 * @param {text} title The desired title of the select.
 * @param {text} message The desired message of the select.
 * @param {text} callback The name of the function to callback to, should be like "functionName(id, value)"
 * @param {text} id The identifier to send back in the callback - eg. "functionName(1234, value)"
 * @param {text} params A desired list of options
 */
App.select = function (title, message, callback, id, params) {
    if (android_app)
        AndroidJS.Select(title, message, callback, id, params);
    else if (ios_app) {
        var s = '';
        for (i = 0; i < params.length; i++) {
            s = s + "&option" + i + "=" + params[i];
        }
        location.href = "hybrid:select?title=" + title + "&message=" + message + "&callback=" + callback + "&id=" + id + s;
    }
    else {
        var arrbuttons = [];

        //TODO ensure buttons are vertically aligned?

        for (i = 0; i < params.length; i++) {
            arrbuttons.push({
                click: function () {
                    if (typeof (callback) == "function")
                        callback(id, params[i]);
                    $(this).dialog("close");
                    $(this).dialog("destroy").remove()
                }, text: params[i]
            });
        }

        $("<div title='" + title + "'><p>" + message + "</p></div>").dialog({
            modal: true,   //dims screen to bring dialog to the front
            buttons: arrbuttons
        });
    }
    return false;
}

/**
 * Shows a select dialog
 * - note on android the message is ignored.
 * - iOS and web not implemented completely.
 *
 * @param {text} title The desired title of the select.
 * @param {text} message The desired message of the select.
 * @param {text} callback The name of the function to callback to, should be like "functionName(id, value)"
 * @param {text} id The identifier to send back in the callback - eg. "functionName(1234, value)"
 * @param {text} params A desired list of options 
 * @param {text} selectedparams A desired list of selected options
 */
App.multiselect = function (title, message, callback, id, params, selectedparams) {
    if (android_app)
        AndroidJS.MultiSelect(title, message, callback, id, params, selectedparams);
    else if (ios_app) {
        var s = '';
        var s1 = '';
        for (i = 0; i < params.length; i++) {
            s = s + "&option" + i + "=" + params[i];
        }
        for (i = 0; i < selectedparams.length; i++) {
            s1 = s1 + "&selected" + i + "=" + selectedparams[i];
        }
        location.href = "hybrid:select?title=" + title + "&message=" + message + "&callback=" + callback + "&id=" + id + s + s1;
    }
    else {
        var arrbuttons = [];

        //TODO ensure buttons are vertically aligned?

        for (i = 0; i < params.length; i++) {
            arrbuttons.push({
                click: function () {
                    if (typeof (callback) == "function")
                        callback(id, params[i]);
                    $(this).dialog("close");
                    $(this).dialog("destroy").remove()
                }, text: params[i]
            });
        }

        $("<div title='" + title + "'><p>" + message + "</p></div>").dialog({
            modal: true,   //dims screen to bring dialog to the front
            buttons: arrbuttons
        });
    }
    return false;
}

/**
 * Sends a request to the bluetooth weigh head for stable weight.
 *
 * @param {text} name The desired weigher to request the weight from (assuming multiple connected)
 * @return {text} will reply by calling JS function AppWeighResult
 */
App.requestWeight = function (name) {
    if (android_app)
        AndroidJS.RequestWeight(name);
    else if (ios_app)
        location.href = "hybrid:requestWeight?name=" + name;
    else {
        if (android) {
            //try chrome bluetooth!?
            //bluetooth not available
            //play store link?
        }
        if (ios) {
            //bluetooth not available
            //app store link?
        }
    }
    return false;
}

/**
 * Requests a connection to the bluetooth device
 *
 * @param {text} name The desired device to connect to.
 * @param {text} type The type of the device - weigher / reader. 
 * @param {text} model The model of the device - pts / allflex etc.
 * @return {bool} will reply by calling JS function AppDeviceConnected
 */
App.connectBTDevice = function (name, type, model) {
    if (android_app)
        AndroidJS.ConnectBTDevice(name, type, model);
    else if (ios_app)
        location.href = "hybrid:connectBTDevice?name=" + name + "&type=" + type;
    else {
        if (android) {
            //try chrome bluetooth!?
            //bluetooth not available
            //play store link?
        }
        if (ios) {
            //bluetooth not available
            //app store link?
        }
    }
    return false;
}

/**
 * Requests a disconnection of all bluetooth devices
 * will reply by calling JS function AppDeviceDisconnected
 */
App.disconnectBT = function () {
    if (android_app)
        AndroidJS.DisconnectBT();
    else if (ios_app)
        location.href = "hybrid:disconnectbt";
    else {
        if (android) {
            //try chrome bluetooth!?
            //bluetooth not available
            //play store link?
        }
        if (ios) {
            //bluetooth not available
            //app store link?
        }
    }
    return false;
}

/**
 * Requests a disconnection of all bluetooth devices by type
 * will reply by calling JS function AppDeviceDisconnected
 * @param {text} type The type of the device - weigher / reader. 
 */
App.disconnectBTType = function (type) {
    if (android_app)
        AndroidJS.DisconnectBTType(type);
    else if (ios_app)
        location.href = "hybrid:disconnectbttype?type=" + type;
    else {
        if (android) {
            //try chrome bluetooth!?
            //bluetooth not available
            //play store link?
        }
        if (ios) {
            //bluetooth not available
            //app store link?
        }
    }
    return false;
}

/**
 * Sends a request to the app to read the text aloud.
 *
 * @param {text} text The desired text to read aloud.
 * @param {bool} expectReply If the user expects the app to await a voice response from the user.
 * @param {text} callback The name of the function to callback to, should be like "functionName(id, value)"
 * @param {text} id The identifier to send back in the callback - eg. "functionName(1234, value)"
 */
App.textToSpeech = function (text, expectReply, callback, id) {
    if (android_app)
        AndroidJS.TextToSpeech(text, expectReply, callback, id);
    else if (ios_app)
        location.href = "hybrid:textToSpeech?text=" + text + "&expectReply=" + expectReply + "&callback=" + callback + "&id=" + id;
    else {
        /** try html5 speech synthesis */
        if ('speechSynthesis' in window) {
            var msg = new SpeechSynthesisUtterance();
            var voices = window.speechSynthesis.getVoices();
            msg.voice = voices[10]; // Note: some voices don't support altering params
            msg.voiceURI = 'native';
            msg.volume = 1; // 0 to 1
            msg.rate = 1; // 0.1 to 10
            msg.pitch = 2; //0 to 2
            msg.text = text;
            msg.lang = 'en-US';

            msg.onend = function (e) {
                if (expectReply) {
                    if ('SpeechRecognition' in window) {
                        // Speech recognition support. Talk to your apps!
                        var recognizer = new SpeechRecogntion();
                        recognizer.onresult = function (e) {
                            if (e.results.length) {
                                var lastResultIdx = e.results.resultIndex;
                                callback(id, e.results[lastResultsIdx][0].transcript);
                                return false;
                            }
                        }
                        recognizer.start();
                    }
                    callback(id, null);
                    return false;
                }
            };

            speechSynthesis.speak(msg);
        }
    }
    return false;
}

/**
 * Causes the device to Vibrate for 100ms
 *
 */
App.shortVibrate = function () {
    App.vibrate(100);
    return false;
}

/**
 * Causes the device to Vibrate for 500ms
 *
 */
App.longVibrate = function () {
    App.vibrate(500);
    return false;
}

/**
 * Causes the device to Vibrate
 *
 * @param {number} duration The desired milliseconds of the vibration.
 */
App.vibrate = function (duration) {
    if (android_app)
        AndroidJS.Vibrate(duration);
    else if (ios_app)
        location.href = "hybrid:vibrate?duration=" + duration;
    else {
        //try to vibrate the device if it's supported
        navigator.vibrate = navigator.vibrate || navigator.webkitVibrate || navigator.mozVibrate || navigator.msVibrate;
        navigator.vibrate(duration);
    }
    return false;
}

App.logOut = function () {
    if (android_app)
        AndroidJS.LogOut();
    else if (ios_app)
        location.href = "hybrid:logout";
    else {
        var cookies = document.cookie.split(";");

        for (var i = 0; i < cookies.length; i++) {
            var cookie = cookies[i];
            var eqPos = cookie.indexOf("=");
            var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
            document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
        }
        db.transaction(function (tx) {
            tx.executeSql('DROP TABLE Cows');
            tx.executeSql('DROP TABLE DynamicLists');
            //tx.executeSql('DROP TABLE Forms');
        });

        window.location.href = 'LoginPage.aspx';
    }
    return false;
}

App.update = function () {
    if (android_app)
        AndroidJS.Update();
    else if (ios_app)
        location.href = "hybrid:update";
    else {
        //clear cache?!
        App.alert("Clear Cache", "Please clear your browser cache to update FarmWizard");
    }
    return false;
}

App.voiceRecognition = function () {
    if (android_app)
        AndroidJS.VoiceRecognition();
    else if (ios_app)
        location.href = "hybrid:voicerecognition";
    else {
        App.alert("Voice Recognition", "This feature is not currently available for web users");
    }
    return false;
}

App.email = function (emailaddress) {
    if (android_app)
        AndroidJS.Email(emailaddress);
    else if (ios_app)
        location.href = "hybrid:email?address=" + emailaddress;
    else {
        location.href = "mailto:" + emailaddress;
    }
    return false;
}

App.call = function (phonenumber) {
    if (android_app)
        AndroidJS.Call(phonenumber);
    else if (ios_app)
        location.href = "hybrid:call?number=" + phonenumber;
    else {
        location.href = "tel:" + phonenumber;
    }
    return false;
}

/**
 * Sends an entire form to the app.
 *
 * @param {form} form to send to the app.
 */
App.sendForm = function (elm) {
    var qs = "";
    var elms = elm.form.elements;

    for (var i = 0; i < elms.length; i++) {
        qs += "&" + elms[i].name + "=" + elms[i].value;
    }

    if (elms.length > 0)
        qs = qs.substring(1);

    location.href = "hybrid:" + elm.name + "?" + qs;
    return false;
}

