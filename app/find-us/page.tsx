import Image from 'next/image'
import type { Metadata } from 'next'
import { SelectableEmailButton } from '@/components/SelectableEmailButton'
import { MusicalDivider } from '@/components/MusicalDivider'

export const metadata: Metadata = {
  title: 'Find Us | Chichester Community Choir',
  description: 'Location and directions to our rehearsals',
}

export default function FindUsPage() {
  return (
    <div className="text-lg leading-relaxed">
      {/* Hero */}
      <section className="bg-gradient-to-br from-choir-blue/95 via-choir-blue/95 to-choir-blue-light/95 text-white py-12 text-center relative overflow-hidden">
        <div className="relative z-10">
          <h1 className="text-5xl mb-4">Find Us</h1>
          <p className="max-w-3xl mx-auto px-4">
            Join us for rehearsals! Here&apos;s where you can find the Chichester Community Choir.
          </p>
        </div>
      </section>

      {/* Location */}
      <section className="px-4">
        <div className="max-w-6xl mx-auto my-12 p-8 bg-white rounded-lg shadow-warm-md border-2 border-choir-warm-gray">
          <h2 className="text-3xl text-choir-blue-dark text-center mb-6">Rehearsal Location</h2>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-8 md:gap-12 items-center">
            <div className="bg-gray-200 rounded-lg h-80 md:h-96 flex items-center justify-center">
              <iframe
                src="https://www.google.com/maps/embed?pb=!1m14!1m8!1m3!1d1497.9585302692021!2d-0.7732953214085532!3d50.84494506711625!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x48744d7d47c733ab%3A0x4fe7a9a44e3150fc!2sUniversity%20of%20Chichester!5e0!3m2!1sen!2suk!4v1740943878324!5m2!1sen!2suk"
                width="100%"
                height="100%"
                style={{ border: 0 }}
                allowFullScreen
                loading="lazy"
                referrerPolicy="no-referrer-when-downgrade"
              />
            </div>
            <div className="p-4">
              <h3 className="text-2xl text-choir-blue mb-2">University of Chichester</h3>
              <p className="mb-4">College Ln, Chichester, PO19 6PF</p>
              <p className="mb-4">
                We rehearse every Tuesday evening from 6:45 PM to 8:15 PM in the cloisters at the University of Chichester.
                The building is accessible via public transit, with parking also available on the university grounds.
              </p>
              <div className="mt-6">
                <h4 className="text-xl text-choir-blue mb-2">Public Transit Options</h4>
                <ul className="list-disc pl-6">
                  <li>Stagecoach Bus Routes: 50 and U7</li>
                  <li>
                    <a href="https://www.stagecoachbus.com/timetables" className="text-choir-blue hover:text-choir-blue-light underline transition-colors">
                      View bus timetables
                    </a>
                  </li>
                </ul>
              </div>
            </div>
          </div>
        </div>
      </section>

      <MusicalDivider variant='icon' image='treble-clef'/>

      {/* Directions */}
      <section className="px-4">
        <div className="max-w-6xl mx-auto my-12 p-8 bg-white rounded-lg shadow-warm-md border-2 border-choir-warm-gray">
          <h2 className="text-3xl text-choir-blue-dark text-center mb-6">Accessing the Rehearsal Room</h2>
          <div className="flex justify-center">
            <a
              href="https://maps.chi.ac.uk/#room=C01-0-31"
              className="inline-flex items-center justify-center gap-2 sm:gap-3 w-full sm:w-auto mb-6 bg-choir-coral hover:bg-choir-coral/90 text-white font-bold text-base sm:text-lg px-6 sm:px-10 py-4 rounded-full shadow-lg hover:shadow-xl transition-all duration-300 transform hover:-translate-y-1 text-center"
            >
            <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor" className="w-6 h-6 shrink-0">
              <path strokeLinecap="round" strokeLinejoin="round" d="M9 6.75V15m6-6v8.25m.503 3.498 4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 0 0-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0Z" />
            </svg>
            <span className="text-sm sm:text-base">View Our Location On Campus Map</span>
            </a>
          </div>
          <Image
            src="https://flhaurczyt40eicf.public.blob.vercel-storage.com/images/better_directions.png"
            alt="Directions to rehearsal room"
            width={800}
            height={600}
            className="w-full h-auto rounded-lg shadow-warm-md"
          />
        </div>
      </section>

      <MusicalDivider variant='icon' image='bass-clef'/>

      {/* Parking */}
      <section className="px-4">
        <div className="max-w-6xl mx-auto my-12 p-8 bg-white rounded-lg shadow-warm-md border-2 border-choir-warm-gray">
          <h2 className="text-3xl text-choir-blue-dark text-center mb-6">Parking Information</h2>
          <p className="text-center max-w-3xl mx-auto mb-4">
            Several parking options are available on the university grounds near our rehearsal space.
          </p>
          <div className="border border-choir-warm-gray rounded-lg overflow-hidden mb-6">
            <div className="bg-gradient-to-r from-choir-blue to-choir-blue-light text-white p-4">
              <h3 className="text-2xl m-0">Paying to Park</h3>
            </div>
            <div className="p-6">
              <p className="mb-4">
                Parking at the university is managed by paybyphone. See below for details:
              </p>
              <div className="flex flex-col sm:flex-row gap-4">
                <div className="bg-choir-peach-tint rounded-lg p-4 sm:flex-1 border border-choir-warm-gray">
                  <h4 className="text-choir-blue font-semibold mb-2">Link</h4>
                  <a href="https://m2.paybyphone.co.uk/parking" className="text-choir-blue hover:text-choir-blue-light underline transition-colors break-all">
                    m2.paybyphone.co.uk
                  </a>
                </div>
                <div className="bg-choir-peach-tint rounded-lg p-4 sm:flex-1 border border-choir-warm-gray">
                  <h4 className="text-choir-blue font-semibold mb-2">Location Number</h4>
                  <p>808365</p>
                </div>
              </div>
            </div>
          </div>
          <div className="border border-choir-warm-gray rounded-lg overflow-hidden">
            <div className="bg-gradient-to-r from-choir-blue to-choir-blue-light text-white p-4">
              <h3 className="text-2xl m-0">Accessible Parking</h3>
            </div>
            <div className="p-6">
              <p className="mb-4">
                There is accessible parking available throughout the university campus.
              </p>
              <div className="flex justify-center">
                <a
                  href="https://maps.chi.ac.uk/"
                  className="inline-flex items-center justify-center gap-3 w-full sm:w-auto bg-choir-coral hover:bg-choir-coral/90 text-white font-bold text-base px-8 py-3 rounded-full shadow-md hover:shadow-lg transition-all duration-300 transform hover:-translate-y-0.5"
                >
                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" strokeWidth={2} stroke="currentColor" className="w-5 h-5">
                  <path strokeLinecap="round" strokeLinejoin="round" d="M9 6.75V15m6-6v8.25m.503 3.498 4.875-2.437c.381-.19.622-.58.622-1.006V4.82c0-.836-.88-1.38-1.628-1.006l-3.869 1.934c-.317.159-.69.159-1.006 0L9.503 3.252a1.125 1.125 0 0 0-1.006 0L3.622 5.689C3.24 5.88 3 6.27 3 6.695V19.18c0 .836.88 1.38 1.628 1.006l3.869-1.934c.317-.159.69-.159 1.006 0l4.994 2.497c.317.158.69.158 1.006 0Z" />
                </svg>
                Click Here To View Campus Map
                </a>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Contact */}
      <section className="bg-gradient-to-br from-choir-blue-dark to-choir-blue text-white py-16 text-center">
        <div className="max-w-3xl mx-auto px-4">
          <h2 className="text-4xl mb-4">Need Help Finding Us?</h2>
          <p className="text-xl mb-8 opacity-90">
            Have questions about parking, accessibility, or anything else? We&apos;re happy to help!
          </p>
          <SelectableEmailButton email="caroline@chicommunitychoir.com" />
        </div>
      </section>
    </div>
  )
}
