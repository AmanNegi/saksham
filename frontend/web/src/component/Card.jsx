// import { IconName } from "react-icons/fa";
function Card({ cardHeading }) {
	return (
		<>
			<article className="w-72 h-96 bg-slate-50 hover:bg-[#3498DA] hover:scale-110 hover:text-white transition-all md:w-80 md:h-96 rounded-xl flex flex-col justify-end p-6 drop-shadow-xl">
				<h3>Get Reward</h3>
				<h4>
					You can keep using your favourite card and keep getting rewards.
				</h4>
			</article>
		</>
	);
}

export default Card;
