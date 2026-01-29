import Link from 'next/link'

export default function Navbar() {
  return (
    <div className="bg-choir-blue-dark text-center border-b-2 border-choir-gold/50">
      <nav className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-6 gap-0 py-4 px-4 max-w-5xl mx-auto">
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
    <Link
      href={href}
      className="text-white text-lg font-semibold px-6 py-2 rounded-lg transition-all duration-200 hover:bg-choir-gold/20 focus:outline-none focus:ring-2 focus:ring-choir-gold/50 focus:ring-offset-2 focus:ring-offset-choir-blue-dark active:translate-y-[1px] no-underline"
    >
      {label}
    </Link>
  )
}
