import React from "react";

const InfoCard = () => {
	return (
		<section
			className="h-screen md:h-[100vh] bg-cover bg-center relative rounded-md md:rounded-[4rem] m-[1rem] md:m-[3rem] flex justify-center items-center"
			style={{ backgroundImage: "url('/background_web_saksham.jpg')" }}>
			<div className="text-white text-center relative z-10">
				<p className="text-[1rem] opacity-100 mb-[8px]">JOIN THE MOVEMENT</p>
				<p className="font-bold text-lg mb-[16px] md:text-2xl lg:text-3xl leading-8 md:leading-10 opacity-100">
					We’re changing the way <br />
					Indians save & invest every day
				</p>
				<button className="inline-block h-14 m-3 line-height-14 px-11 text-base font-semibold text-black no-underline rounded-full bg-white transition duration-300 ease-in-out hover:bg-green-600">
					Click me
				</button>
			</div>
		</section>
	);
};

export default InfoCard;
