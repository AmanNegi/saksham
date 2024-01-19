import google from "../../public/google.png";
import phone from "../../public/phone.png";
import shape_1 from "../../public/shape_1.png";
import shape_2 from "../../public/shape_2.png";
import shape_3 from "../../public/shape_3.png";
import repeat from "../../public/repeat.png";

const Hero = () => {
	return (
		<section className="h-[100vh] text-white relative">
			<div className="absolute top-[50vh] md:top-[25vh] left-[20vw] md:left-[10vw]">
				<div className="font-bold mb-4">
					<h1>Connect,</h1>
					<h1>Protect,</h1>
					<h1>Inform</h1>
				</div>

				<p className="w-[25vw] ">
					Connecting Communities, Ensuring Safety,Bridging Gaps & Combating
					Misinformation
				</p>

				<img className="h-[75px] mt-4" src="/google.png" alt="" />
			</div>
			<div className="absolute right-[0] top-[10vh] opacity-50">
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

			<div className="absolute top-[10vh] md:top-[15vh] left-[30vw] md:left-[60vw]">
				<img className="h-[40vh] md:h-[75vh]" src="/phone.png" alt="" />
			</div>
		</section>
	);
};

export default Hero;
