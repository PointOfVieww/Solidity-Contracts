$(document).ready(function(){

    
    const documentRegistryContractAddress = "0x50016081c5a0749c8149fd95824f0a4c6e80e67b";
    const documentRegistryContractABI = [
        {
            "constant": true,
            "inputs": [
                {
                    "name": "hash",
                    "type": "string"
                }
            ],
            "name": "verifyDocument",
            "outputs": [
                {
                    "name": "",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "view",
            "type": "function"
        },
        {
            "constant": false,
            "inputs": [
                {
                    "name": "hash",
                    "type": "string"
                }
            ],
            "name": "addDocument",
            "outputs": [
                {
                    "name": "dateAdded",
                    "type": "uint256"
                }
            ],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "function"
        },
        {
            "inputs": [],
            "payable": false,
            "stateMutability": "nonpayable",
            "type": "constructor"
        }
    ];
    $('#linkHome').click(function () {
        showView("viewHome")
    });
    $('#linkSubmitDocument').click(function () {
        showView("viewSubmitDocument")
    });
    $('#linkVerifyDocument').click(function () {
        showView("viewVerifyDocument")
    });
        
    $('#documentUploadButton').click(uploadDocument);
    $('#documentVerifyButton').click(verifyDocument);
    // Attach AJAX "loading" event listener
    $(document).on({
        ajaxStart: function () {
            $("#loadingBox").show()
        },
        ajaxStop: function () {
            $("#loadingBox").hide()
        }
    });

    function showView(viewName) {
        // Hide all views and show the selected view only
        $('main > section').hide();
        $('#' + viewName).show();
    }
    
    function showInfo(message) {
        $('#infoBox>p').html(message);
        $('#infoBox').show();
        $('#infoBox>header').click(function () {
            $('#infoBox').hide();
        });
    }
    
    function showError(errorMsg) {
        $('#errorBox>p').html("Error: " + errorMsg);
        $('#errorBox').show();
        $('#errorBox>header').click(function () {
            $('#errorBox').hide();
        });
    }
    
    function uploadDocument(){
        if($('#documentForUpload')[0].files.length == 0){
            return showError("Please select a file to upload");
        }
    
        let fileReader = new FileReader();
        fileReader.onload = function(){
            let documentHash = sha256(fileReader.result);
            if(typeof web3 == 'undefined'){
                return showError("Please install metamask to access eth web3 API");
            }
    
            let contract = web3.eth.contract(documentRegistryContractABI).at(documentRegistryContractAddress);
            contract.addDocument(documentHash,function(err,result,r1,r2,r3){
                if(err){
                    return showError("Smart contract call failed" +e);
                }
                showInfo('Document '+documentHash+'<b>successfully added </b> to the registry.');
            })
        }
        fileReader.readAsBinaryString($('#documentForUpload')[0].files[0]);
    }
    function verifyDocument(){
        if($('#documentToVerify')[0].files.length == 0){
            return showError("Please select a file to verify.");
        }
        let fileReader = new FileReader();
        fileReader.onload = function(){
            let documentHash = sha256(fileReader.result);
            if(typeof web3 == 'undefined'){
                return showError("Please install metamask to access eth web3 API");
            }
    
            let contract = web3.eth.contract(documentRegistryContractABI).at(documentRegistryContractAddress);
            contract.verifyDocument(documentHash,function(err,result,r1,r2,r3){
                if(err){
                    return showError("Smart contract call failed" +e);
                }
                let contractPublishDate = result.c;
                if(contractPublishDate> 0){
                    let displayDate = new Date(contractPublishDate*1000).toLocaleString();
                    showInfo('Document '+documentHash+'is <b>valid </b>,date published: '+displayDate+'');
                }
                else{
                    showInfo('Document '+documentHash+'is <b>invalid </b>: not found in the registry.');
                }
            })
        };
        fileReader.readAsBinaryString($('#documentToVerify')[0].files[0]);
    }
});
