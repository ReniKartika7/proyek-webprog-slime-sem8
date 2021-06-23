<footer>
    <a href="#" class="go-up">
        <i class="fas fa-chevron-up"></i>
    </a>
    <div class="row">
        <div class="col">
            <div class="footer-logo">Slime</div>
            <div class="footer-def">Snack Lives in My Everyday <br>
                Find the right snack just for you in SLIME! We offer affordable, high-grade, pretty, and most important of all, cute imported snacks right on your doorsteps. Become a SLIMER today.
                </div>
        </div>
        <div class="col">
            <div class="footer-title down">Follow us on</div>
            <div class="footer-sosmed">
                <a href="https://www.google.com/intl/id/gmail/about/#" target="_blank">
                    <i class="far fa-envelope"></i>
                </a>
                <a href="https://www.instagram.com/" target="_blank">
                    <i class="fab fa-instagram"></i>
                </a>
                <a href="https://www.twitter.com/" target="_blank">
                    <i class="fab fa-twitter"></i>
                </a>
                <a href="https://www.youtube.com/" target="_blank">
                    <i class="fab fa-youtube"></i>
                </a>
            </div>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col center">
            <div class="footer-title">Copyright</div>
            <div class="footer-payment">
                &copy; Slime 2021
            </div>
        </div>
    </div>
</footer>


<script>
    const goUp = document.querySelector(".go-up");
    window.addEventListener("scroll", () => {
        if (window.pageYOffset > 800) {
            goUp.classList.add("active");
        } else {
            goUp.classList.remove("active");
        }
    })
</script>