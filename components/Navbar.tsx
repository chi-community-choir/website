import Link from 'next/link'

export default function Navbar() {
  return (
    <div className="bg-[#40359b] text-center">
      <nav className="flex justify-center items-center gap-4 flex-wrap py-4 px-4">
        <NavLink href="/" label="Home" />
        <NavLink href="/about" label="About" />
        <NavLink href="/find-us" label="Find Us" />
        <NavLink href="/membership" label="Membership" />
        <NavLink href="/events" label="Events" />
        <NavLink href="/repertoire" label="Repertoire" />
      </nav>
    </div>
  )
}

function NavLink({ href, label }: { href: string; label: string }) {
  return (
    <Link href={href} className="no-underline">
      <button className="bg-white text-black text-xl font-semibold rounded-lg border-2 border-black px-6 py-3 transition-all duration-200 hover:bg-[#f0f4f8] hover:border-[#2c5282] focus:outline-[#90cdf4] focus:outline-offset-2 active:translate-y-[1px]">
        {label}
      </button>
    </Link>
  )
}
