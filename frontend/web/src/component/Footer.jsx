import React from "react";

const Footer = () => {
	return (
		<React.Fragment>
			<section
				className="h-[40vh] bg-[#3EBCF0] flex justify-center items-center "
				style={{
					backgroundImage: 'url("../../public/footerBackground.jpg")',
					backgroundSize: "cover",
					backgroundPosition: "center",
					backdropFilter: "blur(20px)",
				}} id="footer">
				<div className="h-[8rem] m-2 relative">
					<div className="absolute inset-0  opacity-50"></div>
					<p className="font-extrabold-100 font-[#000000] text-[1rem] leading-6  text-center text-black md:text-[2rem] sm:text-[3rem] leading-9">
						Get Unine App on Google
						<br />
						Play or App store
					</p>

					<p className="text-[0.7rem] text-center sm: text-[1rem]">
						Build your financial with a transparent community
					</p>
					<div className="flex justify-center">
						<div>
							<img
								src="/google.png"
								className="w-[30vw] object-contain md:w-[20vh] sm:w-[10vh]"
								alt=""
							/>
						</div>
						<div>
							<img
								src="/google.png"
								className="w-[30vw] object-contain md:w-[20vh] sm:w-[10vh]"
								alt=""
							/>
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
							<input
								type="text"
								placeholder="username@site.com"
								className="input input-bordered join-item"
							/>
							<button className="btn btn-primary bg-[#101010] join-item">
								Subscribe
							</button>
						</div>
					</fieldset>
				</form>
			</footer>
		</React.Fragment>
	);
};

export default Footer;
