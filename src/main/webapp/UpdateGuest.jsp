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

            <!-- First Name / Last Name -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">First Name</label>
                    <input class="form-control" id="firstName" required>
                </div>
                <div class="col-md-6">
                    <label class="form-label">Last Name</label>
                    <input class="form-control" id="lastName" required>
                </div>
            </div>

            <!-- Contact + Email -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">Contact Number</label>
                    <div class="input-group">

                        <select class="form-select" id="countryCode" required>
                            <option value="+1">United States (+1)</option>
                            <option value="+44">United Kingdom (+44)</option>
                            <option value="+91">India (+91)</option>
                            <option value="+94" selected>Sri Lanka (+94)</option>
                            <option value="+93">Afghanistan (+93)</option>
                        </select>

                        <input
                                type="tel"
                                class="form-control"
                                id="contactNumber"
                                pattern="[0-9]{7,15}"
                                maxlength="15"
                                minlength="7"
                                placeholder="Enter phone number"
                                required>
                    </div>
                    <div class="form-text">
                        Select country code and enter 7–15 digits.
                    </div>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Email</label>
                    <input class="form-control" id="email" type="email" required>
                </div>
            </div>

            <!-- ID Type + DOB -->
            <div class="row mb-3">
                <div class="col-md-6">
                    <label class="form-label">ID Type</label>
                    <select class="form-select" id="idType" onchange="updateIdValidation()" required>
                        <option value="NIC">National ID (NIC)</option>
                        <option value="PASSPORT">Passport</option>
                    </select>

                    <label class="form-label mt-2">ID Number</label>
                    <input class="form-control" id="guestIdNo" required>
                    <div class="form-text" id="idHelpText"></div>
                </div>

                <div class="col-md-6">
                    <label class="form-label">Date of Birth</label>
                    <input type="date" id="birthOfDate" class="form-control" required>
                </div>
            </div>

            <!-- Address -->
            <div class="mb-3">
                <label class="form-label">Address</label>
                <textarea class="form-control" id="address" rows="3" required></textarea>
            </div>

        </div>

        <div class="card-footer text-end">
            <button class="btn btn-success" onclick="updateGuest()" type="button">
                Update Guest
            </button>
        </div>
    </div>
</div>

<script>

// Get ID from URL
const urlParams = new URLSearchParams(window.location.search);
const id = urlParams.get("id");
document.getElementById("guestId").value = id;


// Format Date
function formatDate(str) {
    const d = new Date(str);
    const month = (d.getMonth() + 1).toString().padStart(2,'0');
    const day = d.getDate().toString().padStart(2,'0');
    return `${d.getFullYear()}-${month}-${day}`;
}


// 18+ Validation
const todayDate = new Date();
const year18Ago = todayDate.getFullYear() - 18;
const month = String(todayDate.getMonth() + 1).padStart(2, '0');
const day = String(todayDate.getDate()).padStart(2, '0');
const maxDate = `${year18Ago}-${month}-${day}`;
document.getElementById('birthOfDate').setAttribute('max', maxDate);


// ID Validation
function updateIdValidation() {
    const idType = document.getElementById("idType").value;
    const idInput = document.getElementById("guestIdNo");
    const helpText = document.getElementById("idHelpText");

    idInput.value = "";
    idInput.removeAttribute("pattern");

    if (idType === "NIC") {
        idInput.setAttribute("pattern", "[0-9]{12}");
        idInput.setAttribute("maxlength", "12");
        idInput.placeholder = "Enter 12-digit NIC";
        helpText.innerText = "NIC must contain exactly 12 digits.";
    } else {
        idInput.setAttribute("pattern", "[A-Za-z0-9]{9}");
        idInput.setAttribute("maxlength", "9");
        idInput.placeholder = "Enter 9-character Passport";
        helpText.innerText = "Passport must contain exactly 9 letters or numbers.";
    }
}


// Allow only numbers for contact
document.getElementById("contactNumber").addEventListener("input", function() {
    this.value = this.value.replace(/[^0-9]/g, '');
});


// Load Guest Data
fetch("<%= request.getContextPath() %>/api/guests/" + id)
    .then(res => res.json())
    .then(g => {

        document.getElementById("firstName").value = g.FirstName;
        document.getElementById("lastName").value = g.LastName;
        document.getElementById("email").value = g.Email;

        // Split country code and number
        const phone = g.ContactNumber;
        const match = phone.match(/^(\+\d+)(\d+)$/);
        if (match) {
            document.getElementById("countryCode").value = match[1];
            document.getElementById("contactNumber").value = match[2];
        }

        document.getElementById("guestIdNo").value = g.GuestIdNo;
        document.getElementById("birthOfDate").value = formatDate(g.BirthOfDate);
        document.getElementById("address").value = g.Address;

        if(g.IdType){
            document.getElementById("idType").value = g.IdType;
        }

        updateIdValidation();
        document.getElementById("guestIdNo").value = g.GuestIdNo;
    });


// Update Guest
function updateGuest() {

    const fullContact =
        document.getElementById("countryCode").value +
        document.getElementById("contactNumber").value;

    const guest = {
        FirstName: document.getElementById("firstName").value,
        LastName: document.getElementById("lastName").value,
        Email: document.getElementById("email").value,
        ContactNumber: fullContact,
        IdType: document.getElementById("idType").value,
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
        alert("Guest Updated Successfully!");
        window.location.href = "<%= request.getContextPath() %>/ViewGuestsDetails.jsp";
    })
    .catch(err => alert("Error updating guest!"));
}

</script>

</body>
</html>