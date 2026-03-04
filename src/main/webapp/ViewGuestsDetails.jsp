<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>All Guests</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Roboto', sans-serif;
            background-color: #e0f7fa;
        }

        .card {
            border-radius: 15px;
        }

        .card-header {
            background-color: #2193b0 !important;
            color: #fff;
        }

        .table thead {
            background-color: #00838f;
            color: #fff;
            text-align: center;
        }

        .table tbody tr:hover {
            background-color: #b2ebf2;
        }

        .badge-pending {
            background-color: #ffc107 !important;
            color: #000;
        }

        .badge-confirmed {
            background-color: #00c853 !important;
            color: #fff;
        }

        .badge-cancelled {
            background-color: #d50000 !important;
            color: #fff;
        }

        .btn-update {
            background-color: #ffc107 !important;
            color: #000 !important;
            border-radius: 25px;
        }

        .btn-delete {
            background-color: #d50000 !important;
            color: #fff !important;
            border-radius: 25px;
        }

        .btn-print {
            background-color: #2193b0 !important;
            color: #fff !important;
            border-radius: 25px;
        }

        .btn-email {
            background-color: #ff9800 !important;
            color: #fff !important;
            border-radius: 25px;
        }

        .btn {
            margin-right: 5px;
        }

        .action-buttons {
            white-space: nowrap;
        }
    </style>
</head>
<body>

<jsp:include page="Component/NavBar.jsp" />

<div class="container mt-4">
    <div class="card shadow">
        <div class="card-header">
            <h5 class="mb-0 text-white"><i class="bi bi-journal-text me-2"></i>Guest Details</h5>
        </div>

        <div class="card-body">
            <!-- Search box -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <input type="text" id="guestSearch" class="form-control" placeholder="Search by Name, Email, Contact, ID Number..." onkeyup="filterGuests()">
                </div>
            </div>

            <div class="table-responsive">
                <table id="guestTableElement" class="table table-bordered table-striped table-hover align-middle">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>First Name</th>
                            <th>Last Name</th>
                            <th>Contact</th>
                            <th>Email</th>
                            <th>ID Number</th>
                            <th>Date of Birth</th>
                            <th>Address</th>
                            <th class="text-center">Action</th>
                        </tr>
                    </thead>
                    <tbody id="guestTable"></tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<script>
    // Fetch all guests
    fetch("<%= request.getContextPath() %>/api/guests")
        .then(res => res.json())
        .then(data => {
            let rows = "";
            data.forEach(g => {
                let dob = g.BirthOfDate ? new Date(g.BirthOfDate).toISOString().split('T')[0] : "";
                rows += `
                    <tr>
                        <td>${g.GuestId}</td>
                        <td>${g.FirstName}</td>
                        <td>${g.LastName}</td>
                        <td>${g.ContactNumber}</td>
                        <td>${g.Email}</td>
                        <td>${g.GuestIdNo}</td>
                        <td>${dob}</td>
                        <td>${g.Address}</td>
                        <td class="text-center action-buttons">
                            <a href="UpdateGuest.jsp?id=${g.GuestId}" class="btn btn-sm btn-update me-1 mb-1">
                                <i class="bi bi-pencil-square"></i> Update
                            </a>

                        </td>
                    </tr>`;
            });
            document.getElementById("guestTable").innerHTML = rows;
        })
        .catch(err => console.error("Error fetching guests:", err));

    // Delete guest function
    function deleteGuest(id, btn) {
        if(confirm('Are you sure you want to delete this guest?')) {
            fetch("<%= request.getContextPath() %>/api/guests/" + id, {
                method: 'DELETE'
            })
            .then(res => {
                if(res.ok){
                    btn.closest('tr').remove();
                    alert('Guest deleted successfully!');
                } else {
                    alert('Failed to delete guest.');
                }
            })
            .catch(err => alert('Error: ' + err));
        }
    }

    // Filter function
    function filterGuests() {
        const input = document.getElementById("guestSearch");
        const filter = input.value.toLowerCase();
        const table = document.getElementById("guestTableElement");
        const tr = table.getElementsByTagName("tr");

        for(let i = 1; i < tr.length; i++){
            const tdArray = tr[i].getElementsByTagName("td");
            let rowText = "";
            for(let j = 0; j < tdArray.length - 1; j++){ // skip action column
                rowText += tdArray[j].textContent.toLowerCase() + " ";
            }
            tr[i].style.display = rowText.indexOf(filter) > -1 ? "" : "none";
        }
    }
</script>

</body>
</html>