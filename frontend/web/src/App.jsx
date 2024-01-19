import Footer from "./component/Footer";
import Hero from "./component/Hero";
import InfoCard from "./component/InfoCard";
import Nav from "./component/Nav";
import Solution from "./component/Solution";

export default function App() {
	return (
		<>
			<main>
				<Nav />
				<Hero />
				<Solution />
				<InfoCard />
				<Footer />
			</main>
		</>
	);
}
