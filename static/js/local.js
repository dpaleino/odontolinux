$(document).ready(function() {
    function getTime() {
        var d = new Date();
        var t = d.getHours() + ':' + d.getMinutes() + ':' + d.getSeconds();
        return t;
    };

    setInterval(function() {
        $('#navbar-clock').html(getTime());
    }, 1000);
});
