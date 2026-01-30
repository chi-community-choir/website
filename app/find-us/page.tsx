import Image from 'next/image'

export const metadata = {
  title: 'Find Us | Chichester Community Choir',
  description: 'Location and directions to our rehearsals',
}

export default function FindUsPage() {
  return (
    <div className="text-lg leading-relaxed">
      {/* Hero */}
      <section className="bg-gradient-to-br from-choir-blue via-choir-blue to-choir-blue-light text-white py-12 text-center relative overflow-hidden">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_30%_50%,rgba(255,255,255,0.08),transparent_50%)]"></div>
        <div className="relative z-10">
          <h1 className="text-5xl mb-4">Find Us</h1>
          <p className="max-w-3xl mx-auto px-4">
            Join us for rehearsals! Here&apos;s where you can find the Chichester Community Choir.
          </p>
        </div>
      </section>

      {/* Location */}
      <section className="max-w-6xl mx-auto my-12 p-8 bg-white rounded-lg shadow-warm-md border-2 border-choir-warm-gray">
        <h2 className="text-3xl text-choir-blue-dark text-center mb-4">Rehearsal Location</h2>
        <div className="flex flex-wrap gap-8 items-start">
          <div className="flex-1 min-w-[300px]">
            <div className="bg-gray-200 rounded-lg h-96 flex items-center justify-center">
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
          </div>
          <div className="flex-1 min-w-[400px] p-4">
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
      </section>

      {/* Directions */}
      <section className="max-w-6xl mx-auto my-12 p-8 bg-white rounded-lg shadow-warm-md border-2 border-choir-warm-gray">
        <h2 className="text-3xl text-choir-blue-dark text-center mb-6">Accessing the Rehearsal Room</h2>
        <a href="https://maps.chi.ac.uk/#room=C01-0-31" className="block mb-4">
          <div className="bg-choir-peach-tint p-4 rounded-lg text-center hover:bg-choir-peach/30 transition-colors border border-choir-warm-gray">
            <p className="text-choir-blue hover:text-choir-blue-light underline transition-colors font-semibold">
              Click here to see a detailed map of the university campus
            </p>
          </div>
        </a>
        <Image
          src="https://flhaurczyt40eicf.public.blob.vercel-storage.com/images/better_directions.png"
          alt="Directions to rehearsal room"
          className="w-full h-auto rounded-lg shadow-warm-md"
        />
      </section>

      {/* Parking */}
      <section className="max-w-6xl mx-auto my-12 p-8 bg-white rounded-lg shadow-warm-md border-2 border-choir-warm-gray">
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
            <div className="flex flex-wrap gap-6">
              <div className="bg-choir-peach-tint rounded-lg p-4 flex-1 min-w-[200px] border border-choir-warm-gray">
                <h4 className="text-choir-blue font-semibold mb-2">Link</h4>
                <a href="https://m2.paybyphone.co.uk/parking" className="text-choir-blue hover:text-choir-blue-light underline transition-colors">
                  m2.paybyphone.co.uk
                </a>
              </div>
              <div className="bg-choir-peach-tint rounded-lg p-4 flex-1 min-w-[200px] border border-choir-warm-gray">
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
            <a href="https://maps.chi.ac.uk/" className="text-choir-blue hover:text-choir-blue-light underline transition-colors font-semibold">
              See the campus map for more precise parking details
            </a>
          </div>
        </div>
      </section>

      {/* Contact */}
      <section className="bg-choir-blue-dark text-white py-12 text-center">
        <h2 className="text-3xl mb-6">Contact Us for Directions</h2>
        <p className="max-w-2xl mx-auto mb-6 px-4">
          Need help finding us? Have questions about parking or accessibility? We&apos;re here to help!
        </p>
        <div className="flex flex-wrap justify-center gap-8">
          <div>
            <p className="font-bold">Email</p>
            <p>caroline@chicommunitychoir.com</p>
          </div>
        </div>
      </section>
    </div>
  )
}
