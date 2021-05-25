<footer>
    <a href="#" class="go-up">
        <i class="fas fa-chevron-up"></i>
    </a>
    <div class="row">
        <div class="col">
            <div class="footer-logo">Slime</div>
            <div class="footer-def">Lorem ipsumhahahaha hihihi huhuhuLorem ipsumhahahaha hihihi huhuhuLorem ipsumhahahaha hihihi huhuhuLorem ipsumhahahaha hihihi huhuhuLorem ipsumhahahaha hihihi huhuhu</div>
        </div>
        <div class="col">
            <div class="footer-title down">Follow us on</div>
            <div class="footer-sosmed">
                <a href="mailto:reni.hnl@gmail.com" target="_blank">
                    <i class="far fa-envelope"></i>
                </a>
                <a href="https://www.instagram.com/renikartika_/" target="_blank">
                    <i class="fab fa-instagram"></i>
                </a>
                <a href="https://www.linkedin.com/in/reni-kartika/" target="_blank">
                    <i class="fab fa-twitter"></i>
                </a>
                <a href="https://www.kaggle.com/renikartika" target="_blank">
                    <i class="fab fa-youtube"></i>
                </a>
            </div>
        </div>
    </div>
    <hr>
    <div class="row">
        <div class="col center">
            <div class="footer-title">Payment Option</div>
            <div class="footer-payment">
                Gopay, ovo, shopeepay, dana
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