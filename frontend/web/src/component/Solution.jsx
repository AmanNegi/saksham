import Card from "./Card";
import { IoGrid } from "react-icons/io5";
import { FaTag } from "react-icons/fa";
import { FaPhoneVolume } from "react-icons/fa6";
import { FaBell } from "react-icons/fa6";

function Solution() {
	return (
		<article>
			<section className="h-auto space-y-3 p-4 sm:p-10 xl:h-[50vh] xl:flex xl:flex-col xl:justify-center xl:items-center ">
				<h1 className="text-center">Safe & Conveinint transaction</h1>
				<h4 className="text-center">
					Want to pay anything with the touch of a finger. Through UNINE, you
					can make practically any transaction.
				</h4>
			</section>
			<section className=" h-auto grid gap-4 p-4 justify-items-center sm:h-auto sm:grid-cols-2 sm:gap-5 sm:content-end xl:grid-cols-4 xl:h-[50vh] xl:pb-28">
				<Card icon={<FaTag size={50} />}>
					<div className="space-y-6">
						<h3>Issues Management</h3>
						<h5>
							Raise and track issues for everyday problems, monitoring their
							resolution status.
						</h5>
					</div>
				</Card>
				<Card icon={<IoGrid size={50} />}>
					<div className="space-y-6">
						<h3>Efficient Admin UI</h3>
						<h5>
							Admin mode for government officials, ensuring
							streamlinedmanagement of reported problems.
						</h5>
					</div>
				</Card>
				<Card icon={<FaPhoneVolume size={50} />}>
					<div className="space-y-6">
						<h3>Latest Emergency Contacts</h3>
						<h5>
							Accurate, location-based contact details for quick communtication
							with government authorities
						</h5>
					</div>
				</Card>
				<Card icon={<FaBell size={50} />}>
					<div className="space-y-6">
						<h3>Critical Announcement</h3>
						<h5>
							Alerts categorized by priority, keeping citizens informed about
							important messages from local authorities.
						</h5>
					</div>
				</Card>
			</section>
		</article>
	);
}
export default Solution;