<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Guest</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<div class="container mt-5">
    <div class="card shadow">
        <div class="card-header bg-secondary text-white text-center">
            <h4>Update Guest Details</h4>
        </div>
        <div class="card-body">
            <input type="hidden" id="guestId">

            <!-- First Row: First Name & Last Name -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="firstName" class="form-label">First Name</label>
                    <input class="form-control" id="firstName" placeholder="Enter first name">
                </div>
                <div class="col-md-6">
                    <label for="lastName" class="form-label">Last Name</label>
                    <input class="form-control" id="lastName" placeholder="Enter last name">
                </div>
            </div>

            <!-- Second Row: Contact & Email -->
            <div class="row mb-3">
            <div class="col-md-6">
                <label for="contactNumber" class="form-label">Contact Number</label>
                <input
                    type="tel"
                    class="form-control"
                    id="contactNumber"
                    placeholder="Enter contact number"
                    pattern="[0-9]{10,15}"
                    maxlength="15"
                    minlength="10"
                    required
                >
                <div class="form-text">Enter 10 to 15 digits only.</div>
            </div>
                <div class="col-md-6">
                    <label for="email" class="form-label">Email</label>
                    <input class="form-control" id="email" placeholder="Enter email" type="email">
                </div>
            </div>

            <!-- Third Row: ID & DOB -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label for="guestIdNo" class="form-label">ID Number</label>
                    <input class="form-control" id="guestIdNo" placeholder="Enter ID number">
                </div>
                <div class="col-md-6">
                    <label for="birthOfDate" class="form-label">Date of Birth</label>
                    <input class="form-control" id="birthOfDate" type="date">
                </div>
            </div>

            <!-- Address Full Width -->
            <div class="mb-3">
                <label for="address" class="form-label">Address</label>
                <textarea class="form-control" id="address" placeholder="Enter address" rows="3"></textarea>
            </div>
        </div>

        <div class="card-footer text-end">
        <button class="btn btn-success bi bi-pencil-square" onclick="updateGuest()" type="button">Update Guest</button>
        </div>
    </div>
</div>

<script>
// Get guest ID from URL
const urlParams = new URLSearchParams(window.location.search);
const id = urlParams.get("id");
document.getElementById("guestId").value = id;

// Convert date to YYYY-MM-DD
function formatDate(str) {
    const d = new Date(str);
    const month = (d.getMonth() + 1).toString().padStart(2,'0');
    const day = d.getDate().toString().padStart(2,'0');
    return `${d.getFullYear()}-${month}-${day}`;
}

// Load guest details
fetch("<%= request.getContextPath() %>/api/guests/" + id)
    .then(res => res.json())
    .then(g => {
        document.getElementById("firstName").value = g.FirstName;
        document.getElementById("lastName").value = g.LastName;
        document.getElementById("email").value = g.Email;
        document.getElementById("contactNumber").value = g.ContactNumber;
        document.getElementById("guestIdNo").value = g.GuestIdNo;
        document.getElementById("birthOfDate").value = formatDate(g.BirthOfDate);
        document.getElementById("address").value = g.Address;
    })
    .catch(err => console.error("Error fetching guest:", err));
// Update guest
function updateGuest() {
    const guest = {
        FirstName: document.getElementById("firstName").value,
        LastName: document.getElementById("lastName").value,
        Email: document.getElementById("email").value,
        ContactNumber: document.getElementById("contactNumber").value,
        GuestIdNo: document.getElementById("guestIdNo").value,
        BirthOfDate: document.getElementById("birthOfDate").value,
        Address: document.getElementById("address").value
    };

    fetch("<%= request.getContextPath() %>/api/guests/" + id, {
        method: "PUT",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(guest)
    })
    .then(res => res.json())
    .then(msg => {
        alert(msg.message); // optional confirmation
        // Redirect to ViewGuestDetails.jsp for the updated guest
        window.location.href = "<%= request.getContextPath() %>/ViewGuestsDetails.jsp";
    })
    .catch(err => alert("Error updating guest!"));
}
</script>

</body>
</html>