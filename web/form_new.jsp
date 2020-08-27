<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AddressBook</title>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <main class="d-flex align-items-center" style="height:auto;margin-top:50px">
            <div class="container">

                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-header primary-background text-white text-center">
                            <span class="fa-3x fa fa-user"></span> 
                            <h2>Add Contact</h2>
                        </div>

                        <div class="card-body">

                            <div class="form">
                                <h6>Upload File</h6>

                                <form  id="fileupload" method="POST" action="Upload" enctype="multipart/form-data">
                                    <div class="input-group mb-3" >
                                        <div class="custom-file">
                                            <input type="file" accept=".csv" required class="custom-file-input" name="csvfile" id="inputGroupFile04">
                                            <label class="custom-file-label" for="inputGroupFile04">Choose file</label>

                                        </div>
                                        &nbsp
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" name="submit2" type="submit">Upload</button>
                                        </div>

                                    </div>
                                    <div><small class="file-field-msg"></small></div>
                                </form>

                                <h6 class="center-align"><b>*OR*</b></h6>
                            </div>
                            <div class="form" >

                                <form action="RegisterServlet" method="POST" id="myForm" enctype="multipart/form-data" >

                                    <div class="form-row">
                                        <div class="col-md-4 mb-3">
                                            <label for="validationDefault01">First name</label>
                                            <input type="text" pattern="[a-zA-Z]+" maxlength="50" title="Please enter  alphabets only" name="fname" class="form-control" id="validationDefault01" placeholder="First name" required>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="validationDefault02">Last name</label>
                                            <input type="text" pattern="[a-zA-Z]+" maxlength="50" title="Please enter  alphabets only" name="lname" class="form-control" id="validationDefault02" placeholder="Last name"  required>
                                        </div>

                                    </div>
                                    <div class="form-row">
                                        <div class="col-md-4 mb-3">
                                            <label for="validationDefault03">City</label>
                                            <input type="text" pattern="[a-zA-Z]+" maxlength="50" title="Please enter  alphabets only" name="cityn" class="form-control" id="validationDefault03" placeholder="City" required>
                                        </div>

                                        <div class="col-md-4 mb-3">
                                            <label for="validationDefault05">Contact</label>
                                            <input type="text"  name="contc" class="form-control"   id="validationDefault05" placeholder="Contact" required pattern="[789][0-9]{9}" title="requires 10 digits only" >
                                            <small id="contact-field-msg"></small>
                                        </div>
                                        <div class="col-md-4 mb-3">
                                            <label for="validationDefault05">Date of Birth</label>
                                            <input class="form-control" name="bdate"type="Date">

                                        </div>
                                    </div>
                                    <div class="form-row">
                                         
                                        <div class="col-md-8 mb-6">
                                            <label for="validationDefault04">Full Address</label>
                                            <input type="text" name="faddr" class="form-control" id="validationDefault04" placeholder="FullAddress" required>
                                        </div>
                                        
                                        <div class="col-md-4 mb-3">
                                            <label for="validationDefault04">Zip Code</label>
                                            <input type="text" maxlength="6" name="zpcod" class="form-control" id="validationDefault04" placeholder="ZipCode" required pattern="4[0-9]{5}" title="requires 6 digits only">
                                        </div>
                                        
                                    </div>
                                    <center>
                                        <button class="btn btn-primary" style="align-items: center!important" name="submit1" type="submit">Save</button>
                                    </center>
                                </form>

                            </div>
                            <center>
                                <div class="loader center-align" style="margin-top: 10px;display: none">

                                    <div class="spinner-border text-success fa fa-spinner fa-3x">
                                        <h5>Please wait.....</h5>
                                    </div>
                                </div>
                            </center>
                        </div>
                    </div>

                </div>
        </main>

        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/1.0.0/js/materialize.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script src="js/myjs.js" type="text/javascript"></script>
        <script>

            $(document).ready(function () {
                $("#myForm").on('submit', function (event) {
                    event.preventDefault();
                    let f = new FormData(this);
                    console.log(f);
                    $(".loader").show();
                    $(".form").hide();
                    $.ajax({
                        url: "RegisterServlet",
                        data: f,
                        type: 'POST',
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            console.log("sucess");
                            $(".loader").hide();
                            $(".form").show();
                            if (data.trim() === 'done')
                            {
                                swal("Good job!", "Saved Successfully", "success");
                                $("#myForm")[0].reset();
                            } else
                            {
                                swal("Error!", "Something went wrong try again..", "error");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown)
                        {
                            console.log(error);
                            console.log("error");
                            $(".loader").hide();
                            $(".form").show();
                            swal("Error!", "Something went wrong try again..", "error");
                        },
                        processData: false,
                        contentType: false
                    });
                });
            });

        </script>
        <script>
            $('#inputGroupFile04').on('change', function () {
                var fileName = $(this).val();
                $(this).next('.custom-file-label').html(fileName);

                var allowedExtensions = /(\.csv)$/i;

                if (!allowedExtensions.test(fileName)) {

                    $(".file-field-msg").html("required .csv files only! ").addClass("text-danger");

                    return false;
                } else
                {
                    $(".file-field-msg").html("Valid file").removeClass("text-danger").addClass("text-success");
                    return true;
                }
            });


        </script>
        <script>

            $(document).ready(function () {
                $("#fileupload").on('submit', function (event) {
                    event.preventDefault();
                    let f = new FormData(this);
                    var fileName = $('#inputGroupFile04').val();
                    
                    $(this).next('.custom-file-label').html(fileName);
                    var allowedExtensions = /(\.csv)$/i;
                    if (!allowedExtensions.test(fileName)) {
                        $(".file-field-msg").html("required .csv files only! ").addClass("text-danger");
                        return false;
                    }
                    $(".loader").show();
                    $(".form").hide();
                    $.ajax({
                        url: "Upload",
                        data: f,
                        type: 'POST',
                        success: function (data, textStatus, jqXHR) {
                            console.log(data);
                            console.log("sucess!!");
                            $(".loader").hide();
                            $(".form").show();
                            if (data.trim() === 'done')
                            {
                                swal("Good job!", "Saved Successfully", "success");
                            } else
                            {
                                swal("Error!", "Something went wrong try again..", "error");
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown)
                        {
                            console.log(error);
                            console.log("error");
                            $(".loader").hide();
                            $(".form").show();
                            swal("Error!", "Something went wrong try again..", "error");
                        },
                        processData: false,
                        contentType: false

                    });
                });
            });

        </script>
    </body>
</html>
