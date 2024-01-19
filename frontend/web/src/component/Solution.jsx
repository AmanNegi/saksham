import Card from "./Card";

function Solution() {
	return (
		<article>
			<section className="h-auto space-y-3 p-4 sm:p-10 xl:h-[50vh] xl:flex xl:flex-col xl:justify-center xl:items-center">
				<h1 className="text-center">Safe & Conveinint transaction</h1>
				<p className="text-center">
					Want to pay anything with the touch of a finger. Through UNINE, you
					can make practically any transaction.
				</p>
			</section>
			<section className="h-auto grid gap-4 p-4 content-end justify-items-center sm:h-auto sm:grid-cols-2 sm:gap-5 sm:content-end xl:grid-cols-4 xl:h-[50vh] xl:mb-20">
				<Card />
				<Card />
				<Card />
				<Card />
			</section>
		</article>
	);
}
export default Solution;
