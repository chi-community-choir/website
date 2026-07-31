import { CHOIR_CONTACT, REHEARSAL, VENUE, SITE } from '@/lib/constants'

export default function Footer() {
  return (
    <footer className="bg-choir-blue-dark text-white py-12 border-t-4 border-choir-gold">
      <div className="max-w-6xl mx-auto px-4">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-12 text-center md:text-left">
          <div>
            <h3 className="font-bold text-xl mb-4 text-white">Contact Us</h3>
            <p className="text-gray-300">
                <a href={`mailto:${CHOIR_CONTACT.email}`} className="hover:text-white transition-colors">
                  {CHOIR_CONTACT.email}
                </a>
            </p>
          </div>

          <div>
            <h3 className="font-bold text-xl mb-4 text-white">Rehearsals</h3>
              <p className="text-gray-300">
                Every {REHEARSAL.day}<br />
                {REHEARSAL.time}<br />
                {VENUE.name}
              </p>
          </div>

          <div>
            <h3 className="font-bold text-xl mb-4 text-white">Join Us</h3>
            <p className="text-gray-300">
              No auditions required<br />
              First session is free!
            </p>
          </div>
        </div>

        <div className="mt-12 pt-8 border-t border-gray-600 text-center text-gray-400">
            <p>&copy; {new Date().getFullYear()} {SITE.name}. All rights reserved.</p>
        </div>
      </div>
    </footer>
  )
}
