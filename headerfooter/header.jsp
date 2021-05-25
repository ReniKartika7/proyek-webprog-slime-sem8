<%
    String currentPath = request.getRealPath(request.getServletPath()).replace('\\', '/');
    currentPath = currentPath.substring(23 ,currentPath.length());
%>

<div class="header-position">
    <div id="side-nav" class="side-nav">
        <a href="javascript:void(0)" class="close-icon" onclick="closeSideNav()">&times;</a>
        <a href="<%= productPath %>">Product</a>
        <% if (users("guest")) {%>
            <a href="<%= loginPath %>">Account</a>
        <% } else if(users("customer")) {%>
            <a href="<%= root %>/customer/myProfile.jsp">Account</a>
        <% } %>
        <a href="<%= root %>/aboutUs.jsp">About Us</a>
    </div>

    <div id="search-bar" class="search-bar">
        <a href="javascript:void(0)" class="close-icon" onclick="closeSearchBar()">&times;</a>

        <div class="search-content">
            <i class="fas fa-search"></i>
            <form method="GET">
                <input type="text" name="search" class="search" id="search" placeholder="Search...">
            </form>
        </div>
    </div>

    <div class="header-item logo">
        <a href="<%= indexPath %>">
            Slime
        </a>
    </div>
    <div class="navbar header-item">
        <ul class="navbar-content" id="navbar-content">
            <li class="navbar-item">
                <a href="<%= productPath %>">Product</a>
            </li>
            <li class="navbar-item">
                <a href="<%= root %>/aboutUs.jsp">About Us</a>
            </li>
        </ul>
    </div>
    <div class="header-item icon">
        <% if(currentPath.equals(productPath) || currentPath.equals(manageUserPath)) {%>
            <span class="icons" onclick="openSearchBar()">
                <i class="fas fa-search"></i>
            </span>
        <% }
        if (users("guest")) {%>
            <a href="<%= loginPath %>" class="icons">
                <i class="fas fa-user"></i>
            </a>
        <% } else if(users("customer")) {%>
            <a href="<%= root %>/customer/myProfile.jsp" class="icons">
                <i class="fas fa-user"></i>
            </a>
        <% } %>
        
        <a href="<%= root %>/cart/myCart.jsp" class="icons">
            <i class="fas fa-shopping-cart"></i>
        </a>
        
        <% if (users("customer")) {%>
            <div class="dropdown">
                <a href="javascript:void(0)" class="icons" onclick="openDropDown()">
                    <i class="fas fa-cog"></i>
                </a>
                <div class="dropdown-content" id="dropdown-content">
                    <a href="#">My Address</a>
                    <a href="<%= root %>/customer/changePassword.jsp">Change Password</a>
                    <a href="<%= root %>/doLogout.jsp">Log Out</a>
                </div>
            </div>
        <% } else if (users("admin")) {%>
            <div class="dropdown">
                <a href="javascript:void(0)" class="icons" onclick="openDropDown()">
                    <i class="fas fa-cog"></i>
                </a>
                <div class="dropdown-content" id="dropdown-content">
                    <a href="<%= manageUserPath %>">Manage Users</a>
                    <a href="#">Manage Products</a>
                    <a href="#">Manage Payment Type</a>
                    <a href="<%= root %>/doLogout.jsp">Log Out</a>
                </div>
            </div>
        <% } %>
    </div>

    <a href="javascript:void(0);" class="responsive-icon" onclick="openSideNav()">
        <i class="fa fa-bars"></i>
    </a>

    <input type="hidden" name="root" id="root" value="<%= root +"/" %>">
</div>

<script>
    $(function(){
        var current = location.pathname;
        var root = document.getElementById("root").value;
        if(current != root){
            current = current.substring(1, current.length-5);
            
            $('#navbar-content li a').each(function(){
            var $this = $(this);
            if($this.attr('href').indexOf(current) !== -1){
                $this.addClass('active-navbar');
            }
        })
        }
    })

    // Side Navbar
    function openSideNav(){
        document.getElementById("side-nav").style.width="100%";
    }

    function closeSideNav(){
        document.getElementById("side-nav").style.width="0";
    }

    // Search bar
    function openSearchBar(){
        document.getElementById("search-bar").style.height="4.2rem";
        document.getElementById("image-container").style.filter="grayscale(100%)";
        document.body.style.backgroundColor = "rgba(0,0,0,0.5)";
        document.body.style.overflow = "hidden";
    }

    function closeSearchBar(){
        document.getElementById("search-bar").style.height="0";
        document.getElementById("image-container").style.filter="grayscale(0%)";
        document.body.style.backgroundColor = "white";
        document.body.style.overflow = "scroll";
    }

    //DropDown
    function openDropDown(){
        if (document.getElementById("dropdown-content").style.display == "none") {
            document.getElementById("dropdown-content").style.display = "block";
        }else{
            document.getElementById("dropdown-content").style.display = "none";
        }
    }
</script>