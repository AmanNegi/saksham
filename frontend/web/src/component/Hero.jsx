import google from "../../public/google.png";
import phone from "../../public/phone.png";
import shape_1 from "../../public/shape_1.png";
import shape_2 from "../../public/shape_2.png";
import shape_3 from "../../public/shape_3.png";
import repeat from "../../public/repeat.png";
import Nav from "./../component/Nav";
const Hero = () => {
	return (

		<section className="h-[100vh] text-white relative bg-black  ">
			<Nav/>
			<div className="absolute top-[50vh] mt-[4px] sm:top-[35vh] md:left-[10vw]">
				<div className="font-bold mb-[4px] text-center text-[1.5rem] sm:text-[3rem] text-center">
					Saksham App
				</div>
                <div className="hidden sm:block text-center text-[1rem]">Empower, Connect, Secure  </div>
				<p className="text-center md:hidden">
				Empower, Connect, Secure  <span className="flex flex-row"> Bridging Gaps in Emergencies, Community, and Information with Our App!</span>
				</p>

				<img className="h-[75px] mt-4 absolute left-[11vh] sm:left-[8vh]" src="/google.png" alt="" />
			</div>
			<div className="absolute right-[0] top-[10vh] opacity-50 sm:left-[4vh]">
				{/* <img
                className="hidden md:flex h-[90vh] object-contain"
                src={shape_1}
                alt=""
            /> */}
				<img className="w-[40vw] opacity-40" src="/shape_2.png" alt="" />
			</div>

			<div className="absolute top-0 opacity-20">
				<img src={shape_3} className="w-[20vw] object-contain " alt="" />
			</div>

			<div className="absolute top-[10vh] left-[12.7vh] md:top-[15vh] left-[30vw] md:left-[60vw]">
				<img className="h-[40vh] md:h-[75vh] " src="/phone.png" alt="" />
			</div>
		</section>
	);
};

export default Hero;
