
const Footer = () => {
    return (

        <>
           <section className="h-[40vh] bg-[#3EBCF0] flex justify-center items-center relative" style={{ backgroundImage: 'url("../../public/footerBackground.jpg")', backgroundSize: 'cover', backgroundPosition: 'center', backdropFilter: 'blur(20px)' }}>
    <div className="h-[8rem] m-2 relative">
        <div className="absolute inset-0  opacity-50"></div>
        <p className="font-extrabold font-[#000000] text-[2rem] leading-10 text-center text-black">
            Get Unine App on Google
            <br />
            Play or App store
        </p>

        <p className="text-[1rem] text-center">Build your financial with a transparent community</p>
        <div className="flex justify-center">
            <div>
                <img src="/google.png" className="w-[10vw] object-contain" alt="" />
            </div>
            <div>
                <img src="/google.png" className="w-[10vw] object-contain" alt="" />
            </div>
        </div>
    </div>
</section>


            <footer className="footer p-10 bg-base-200 text-base-content">
                <nav>
                    <header className="footer-title">Services</header>
                    <a className="link link-hover">Branding</a>
                    <a className="link link-hover">Design</a>
                    <a className="link link-hover">Marketing</a>
                    <a className="link link-hover">Advertisement</a>
                </nav>
                <nav>
                    <header className="footer-title">Company</header>
                    <a className="link link-hover">About us</a>
                    <a className="link link-hover">Contact</a>
                    <a className="link link-hover">Jobs</a>
                    <a className="link link-hover">Press kit</a>
                </nav>
                <nav>
                    <header className="footer-title">Legal</header>
                    <a className="link link-hover">Terms of use</a>
                    <a className="link link-hover">Privacy policy</a>
                    <a className="link link-hover">Cookie policy</a>
                </nav>
                <form>
                    <header className="footer-title">Newsletter</header>
                    <fieldset className="form-control w-80">
                        <label className="label">
                            <span className="label-text">Enter your email address</span>
                        </label>
                        <div className="join">
                            <input type="text" placeholder="username@site.com" className="input input-bordered join-item" />
                            <button className="btn btn-primary bg-[#101010] join-item">Subscribe</button>
                        </div>
                    </fieldset>
                </form>
            </footer>
        </>
    )
}


export default Footer;