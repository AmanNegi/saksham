const Nav = () => {
	return (
	  <nav className="relative w-full bg-transparent border-gray-200 z-10">
		<div className="max-w-screen-xl flex flex-wrap items-center justify-between mx-auto p-4">
		  <a href="https://flowbite.com/" className="flex items-center space-x-3 rtl:space-x-reverse">
			<img
			  src="https://flowbite.com/docs/images/logo.svg"
			  className="h-8"
			  alt="Flowbite Logo"
			/>
			<span className="self-center text-2xl text-white font-semibold whitespace-nowrap">
			  Saksham
			</span>
		  </a>
		  <div className="flex md:order-2 space-x-3 md:space-x-0 rtl:space-x-reverse">
			<button
			  type="button"
			  className="text-white bg-[#3498DA]  focus:ring-4 focus:outline-none focus:ring-blue-300 font-medium rounded-lg text-sm px-4 py-2 text-center :bg-blue-600">
			  Download now
			</button>
			<button
			  data-collapse-toggle="navbar-cta"
			  type="button"
			  className="inline-flex items-center p-2 w-10 h-10 justify-center text-sm text-gray-500 rounded-lg md:hidden focus:outline-none focus:ring-2 focus:ring-gray-200"
			  aria-controls="navbar-cta"
			  aria-expanded="false">
			  <span className="sr-only">Open main menu</span>
			  <svg
				className="w-5 h-5"
				aria-hidden="true"
				xmlns="http://www.w3.org/2000/svg"
				fill="none"
				viewBox="0 0 17 14">
				<path
				  stroke="currentColor"
				  strokeLinecap="round"
				  strokeLinejoin="round"
				  strokeWidth="2"
				  d="M1 1h15M1 7h15M1 13h15"
				/>
			  </svg>
			</button>
		  </div>
		  <div
			className="items-center justify-between hidden w-full md:flex md:w-auto md:order-1"
			id="navbar-cta">
			<ul className="flex flex-col font-medium p-4 md:p-0 mt-4 border border-gray-100 rounded-lg md:space-x-8 rtl:space-x-reverse md:flex-row md:mt-0 md:border-0">
			  <li>
				<a
				  href="#"
				  className="block py-2 px-3 md:p-0 text-white bg-blue-700 rounded md:bg-transparent md:text-blue-700"
				  aria-current="page">
				  Home
				</a>
			  </li>
			  <li>
				<a
				  href="#solution"
				  className="block py-2 px-3 md:p-0 text-white rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700 md">
				  Solution
				</a>
			  </li>
  
			  <li>
				<a
				  href="#footer"
				  className="block py-2 px-3 md:p-0 text-white  rounded hover:bg-gray-100 md:hover:bg-transparent md:hover:text-blue-700">
				  Contact
				</a>
			  </li>
			</ul>
		  </div>
		</div>
	  </nav>
	);
  };
  
  export default Nav;
  