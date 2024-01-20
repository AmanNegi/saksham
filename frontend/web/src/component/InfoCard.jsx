import React from "react";

const InfoCard = () => {
	return (
		<section
			className="h-[50vh] md:h-[100vh] bg-cover bg-center relative rounded-md md:rounded-[4rem] m-[1rem] md:m-[3rem] flex justify-center items-center"
			style={{ backgroundImage: "url('/background_web_saksham.jpg')" }}>
			<div className="text-white text-center relative z-10">
				<p className="text-[0.8rem] opacity-100 mb-[8px] sm:text-[1rem]">
					JOIN THE MOVEMENT
				</p>
				<p className="font-bold text-[1rem] mb-[16px] md:text-2xl lg:text-3xl leading-8 md:leading-10 opacity-100">
					We’re changing the way Indians
					<br />
					report and track their everyday issues.
				</p>
				<button className="inline-block sm:h-14 sm:m-3 h-12 m-2 line-height-12 sm:px-11 px-8 text-sm sm:text-base font-semibold text-black no-underline rounded-full bg-white transition duration-300 ease-in-out hover:bg-[black] hover:text-white">
					Download Now
				</button>
			</div>
		</section>
	);
};

export default InfoCard;
