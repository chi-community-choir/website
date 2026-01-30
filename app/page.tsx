import InfoBox from '@/components/InfoBox'
import Image from 'next/image'

export default function Home() {
  return (
    <div className="flex flex-col items-center text-lg leading-relaxed">
      {/* Hero Banner */}
      <section className="py-8 px-4">
        <div className="max-w-7xl mx-auto">
          <div className="bg-gray-200 rounded-lg overflow-hidden">
            <Image
              src="https://flhaurczyt40eicf.public.blob.vercel-storage.com/images/2019-12-13-Choir-Header-1.png"
              alt="Chichester Community Choir banner"
              width={1280}
              height={325}
              className="w-full h-auto shadow-warm-md"
              priority
            />
          </div>
        </div>
      </section>

      {/* Welcome Section */}
      <section className="px-4">
        <div className="max-w-4xl mx-auto mb-12 p-8 bg-white rounded-lg text-center shadow-warm-md border-2 border-choir-warm-gray">
        <h1 className="text-choir-blue-dark text-4xl font-bold mb-6">
          Welcome to Chichester Community Choir
        </h1>
        <p className="text-lg text-gray-700">
          Join us in the joy of singing! No auditions required - just bring your enthusiasm and love for music.
        </p>
        </div>
      </section>

      {/* Info Boxes */}
      <section className="max-w-6xl mx-auto mb-12 px-4">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <InfoBox title="Next Rehearsal" linkHref="/find-us" linkText="Find Us">
            <p>
              Every Tuesday<br />
              6:45 PM - 8:15 PM<br />
              University of Chichester
            </p>
          </InfoBox>

          <InfoBox title="Want to Join?" linkHref="mailto:caroline@chicommunitychoir.com" linkText="Contact Us to Join">
            <p>
              Your first session is free!<br />
              Come along and give it a try.<br />
            </p>
          </InfoBox>

          <InfoBox title="Latest News" linkHref="/events" linkText="View Events">
            <p>
              Stay tuned for upcoming<br />
              performances and events.<br />
              See you there!
            </p>
          </InfoBox>
        </div>
      </section>

      {/* CTA Bottom */}
      <section className="px-4">
        <div className="bg-gradient-to-br from-choir-peach/20 to-choir-sunshine p-12 text-center rounded-xl max-w-4xl mx-auto mb-12 border-4 border-choir-gold shadow-warm-2xl relative overflow-hidden">
          {/* Decorative element */}
          <div className="absolute inset-0 bg-[radial-gradient(circle_at_50%_120%,rgba(255,255,255,0.3),transparent_50%)]"></div>
          <div className="relative z-10">
            <h2 className="text-choir-blue-dark text-5xl font-bold mb-6 drop-shadow-sm">
              Come Sing With Us!
            </h2>
            <p className="text-xl text-gray-800 max-w-2xl mx-auto mb-8 leading-relaxed">
              Experience the joy of singing together in a friendly, welcoming environment. No previous experience needed!
            </p>
            <a
              href="/membership"
              className="inline-block bg-gradient-to-r from-choir-coral-dark to-choir-coral text-white px-12 py-5 rounded-xl text-2xl font-bold no-underline transition-all hover:scale-105 hover:shadow-warm-2xl focus:outline-none focus:ring-4 focus:ring-choir-gold focus:ring-offset-2 active:translate-y-[1px] shadow-warm-xl border-2 border-white/30"
            >
              Join the Choir
            </a>
          </div>
        </div>
      </section>
    </div>
  )
}
