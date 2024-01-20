import { Children } from "react";
import { FaTag } from "react-icons/fa";
function Card({ icon, children }) {
	return (
		<>
			<article className="group w-72 h-80 bg-slate-50 hover:bg-[#3498DA] hover:scale-110 hover:text-white transition-all md:w-80 md:h-96 rounded-xl flex flex-col justify-end p-6 drop-shadow-xl">
				<div className="w-full h-full">
					<div className="w-16 h-16 p-2 flex justify-center items-center rounded-lg group-hover:bg-white group-hover:text-[#3498DA]">
						{icon}
					</div>
				</div>
				{children}
			</article>
		</>
	);
}

export default Card;
