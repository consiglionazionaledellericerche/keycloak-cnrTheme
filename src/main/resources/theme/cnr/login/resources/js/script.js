$(document).ready(function(){
    var rootList = $("#spid-idp-list-medium-root-get");
    var idpList = rootList.children(".spid-idp-button-link");
    var lnkList = rootList.children(".spid-idp-support-link");
    while (idpList.length) {
        rootList.append(idpList.splice(Math.floor(Math.random() * idpList.length), 1)[0]);
    }
    rootList.append(lnkList);
});