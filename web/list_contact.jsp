<%@page import="com.mysql.jdbc.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>AddressBook</title>

        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
        <link href="css/style.css" rel="stylesheet" type="text/css"/>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.10.19/css/jquery.dataTables.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.bootstrap.min.css">
        <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.3/css/responsive.jqueryui.min.css">
        <style>
            .table {
                border-radius: 5px;
                width: 70%;
                margin: 0px auto;
                float: none;
            }
        </style>
    </head>

    <body>

        <%@include file="navbar.jsp" %>
        <div class="container-fluid p-5 mb-3">
            <center>
                <h3 class="center-align">Contact List</h3>
            </center>

            <div class="data-tables">
                <div class="table-responsive">
                    <table id="dtBasicExample" class="table table-bordered" style="width:100%">

                        <thead>
                            <tr>
                                <th data-visible="false">Contact Id</th>
                                <th>First Name</th>
                                <th scope="col">Last Name</th>
                                <th scope="col">City</th>
                                <th scope="col">Birth Date</th>
                                <th scope="col">Contact No</th>
                                <th scope="col">Full Address</th>
                                   <th scope="col" > ZipCode</th>
                                <th scope="col">Reviewed?</th>
                                <th scope="col">Actions</th>

                            </tr>
                        </thead>
                        <tbody>      
                            <c:forEach items="${contacts}" var="contact">
                                <tr>
                                    <td><c:out value="${contact.contact_id}" /></td>
                                    <td><c:out value="${contact.first_name}" /></td>
                                    <td><c:out value="${contact.last_name}" /></td>
                                    <td><c:out value="${contact.city}" /></td>
                                    <td><fmt:formatDate pattern="yyyy-MMM-dd" value="${contact.birthdate}" /></td>
                                    <td><c:out value="${contact.contact}" /></td>
                                    <td><c:out value="${contact.full_address}" /></td>
                                     <td><c:out value="${contact.zip_code}" /></td>
                                    <c:if test="${contact.review == true}" >
                                        <td style="text-align: center"><input type="checkbox" class="checkbox-field" id="${contact.contact_id}" name="rview" checked > </td>
                                        </c:if>
                                        <c:if test="${contact.review == false}" >
                                        <td style="text-align: center"><input type="checkbox" class="checkbox-field" id="${contact.contact_id}" name="rview"  > </td>
                                        </c:if>
                                    <td>

                                        <a href="Edit?u=${contact.contact_id}" class="edit" title="Edit" data-toggle="tooltip"><i class="material-icons">&#xE254;</i></a>
                                        <a class="delete_button" href="/" id="${contact.contact_id}"  class="delete" title="Delete" data-toggle="tooltip"><i class="material-icons">&#xE872;</i></a>

                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>

        </div>

        <script src="js/myjs.js" type="text/javascript"></script>
        <script src="https://code.jquery.com/jquery-3.5.1.min.js" integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="https://cdn.datatables.net/1.10.15/js/jquery.dataTables.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"></script>
        <script>
            $(document).ready(function () {
                $('#dtBasicExample').DataTable(
                        {
                            responsive: true
                        }
                );
            });
        </script>
        <script>
            $(":checkbox").click(function () {

                var checked_id = this.id;

                if ($(this).prop("checked") == true)
                {
                    swal({
                        title: "Confirm",
                        text: "Do you really want to review this contact?",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    })
                            .then((willCheck) => {
                                if (willCheck) {

                                    $.ajax({
                                        type: "POST",
                                        url: "Update",
                                        data: {"d": checked_id, "c": true},
                                        success: function (data, textStatus, jqXHR) {
                                            console.log("sucess");

                                            if (data.trim() === 'done')
                                            {
                                                swal("Great!", "Contact reviewed Successfully", "success");
                                                $(row).find("input:checkbox").prop("checked", true);
                                            }
                                        }
                                    });
                                }
                            });
                } else
                {
                    swal({
                        title: "Confirm",
                        text: "Do you really want to unmark this contact?",
                        icon: "warning",
                        buttons: true,
                        dangerMode: true,
                    })
                            .then((willCheck) => {
                                if (willCheck) {

                                    $.ajax({
                                        type: "POST",
                                        url: "Update",
                                        data: {"d": checked_id, "c": false},
                                        success: function (data, textStatus, jqXHR) {
                                            console.log("sucess");

                                            if (data.trim() === 'done')
                                            {
                                                swal("Great!", "Contact unmarked!", "success");
                                                $(row).find("input:checkbox").prop("checked", false);
                                            }
                                        }
                                    });

                                }
                            });
                }
            });

        </script>
        <script>
            var $delete_button = $('.delete_button');
            $delete_button.on('click', function (e)
            {
                e.preventDefault();
                var row = this;
                var delete_id = this.id;
                console.log(delete_id);
                swal({
                    title: "Are you sure?",
                    text: "Do you really want to delete  this contact?",
                    icon: "warning",
                    buttons: true,
                    dangerMode: true,
                })
                        .then((willDelete) => {
                            if (willDelete) {

                                $.ajax({
                                    type: "POST",
                                    url: "Delete",
                                    data: {"d": delete_id},
                                    success: function (data, textStatus, jqXHR) {
                                        console.log("sucess");

                                        if (data.trim() === 'done')
                                        {
                                            swal("Good job!", "Contact Deleted Successfully", "success");
                                            $(row).closest('tr').fadeOut(800, function () {
                                                $(this).remove();
                                            })
                                        } else
                                        {
                                            swal("Error!", "Something went wrong try again..", "error");
                                        }
                                    }
                                });

                            }
                        });
            });
        </script>
    </body>
</html>


