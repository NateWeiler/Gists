$.ajaxSetup({
    cache: false
});

var currentPath = [];

function isDefined(x) {
    var undefinedVar;
    return x !== undefinedVar;
}

function getCurrentPath () {
    return currentPath.join ("/");
}

function updateDirectoryContent (data) {
    $("#explorer").empty ();
    $.each(data, function () {
        var dataAttribute = "";
        if (this.isDir) {
            dataAttribute = " data-directory='true'";
        }
        $("#explorer").append ('<li' + dataAttribute + '>' + this.path + '</li>');
    });
}

function startDirectoryContent () {
    $.ajax ({
        'url': 'getpath.php',
        'type': 'post',
        'data': { 'path':  getCurrentPath () },
        'dataType' : 'json',
        'success': updateDirectoryContent});
}

function handleDirectoryClickEvent () {
    if (!isDefined ($(this).attr ("data-directory"))) {
        var url = encodeURIComponent (getCurrentPath () + "/" + $(this).text ());
        $("#player").attr ("src", "fetch.php?filename=" + url);
        document.getElementById('player').load();
        document.getElementById('player').play();
        return;
    }
    currentPath.push ($(this).text ());
    startDirectoryContent ();
}

function topDirectory (event) {
    if (event) {
        event.preventDefault();
    }
    currentPath = [];
    currentPath.push (".");
    startDirectoryContent ();
}

function upDirectory (event) {
    if (event) {
        event.preventDefault();
    }
    if (currentPath.length == 1) return;
    currentPath.pop ();
    startDirectoryContent ();
}

$(document).ready(function() {
    topDirectory ();
    $("body").on ("click", "#explorer li", handleDirectoryClickEvent);
    $("#buttonHome").on ("click", topDirectory);
    $("#buttonUp").on ("click", upDirectory);
});