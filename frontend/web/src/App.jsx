
import Footer from "./component/Footer";
import Hero from "./component/Hero";
import InfoCard from "./component/InfoCard";
import Nav from "./component/Nav";

export default function App() {
	return (
		<>
			<main>
				<Nav/>
			     <Hero/>
				 <section className="h-[100vh]"></section>
				 <InfoCard/>

			    <Footer/>
			</main>
		</>
	);
}
