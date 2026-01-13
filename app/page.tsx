import HeroSection from '@/components/HeroSection'
import InfoBox from '@/components/InfoBox'

export default function Home() {
  return (
    <div className="flex flex-col items-center text-lg leading-relaxed">
      {/* Hero Banner */}
      <HeroSection />

      {/* Welcome Section */}
      <section className="max-w-4xl mx-auto mb-12 p-8 bg-gray-50 rounded-lg text-center">
        <h1 className="text-choir-blue-dark text-4xl font-bold mb-6">
          Welcome to Chichester Community Choir
        </h1>
        <p className="text-lg text-gray-700">
          Join us in the joy of singing! No auditions required - just bring your enthusiasm and love for music.
        </p>
      </section>

      {/* Info Boxes */}
      <section className="max-w-6xl mx-auto mb-12 px-4">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8">
          <InfoBox title="Next Rehearsal" linkHref="/find-us" linkText="Find Us">
            <p>
              Every Tuesday<br />
              7:30 PM - 9:30 PM<br />
              University of Chichester
            </p>
          </InfoBox>

          <InfoBox title="Want to Join?">
            <p className="mb-4">
              Your first session is free! Come along and give it a try.
            </p>
            <a
              href="mailto:caroline@chicommunitychoir.com"
              className="inline-block bg-choir-blue text-white px-6 py-3 rounded-lg text-lg no-underline transition-all hover:bg-choir-blue-dark focus:outline-none focus:ring-2 focus:ring-choir-blue focus:ring-offset-2 active:translate-y-[1px]"
            >
              Contact Us to Join
            </a>
          </InfoBox>

          <InfoBox title="Latest News" linkHref="/events" linkText="View Events">
            <p>Stay tuned for upcoming performances and events!</p>
          </InfoBox>
        </div>
      </section>

      {/* CTA Bottom */}
      <section className="bg-gray-100 p-8 text-center rounded-lg max-w-4xl mx-auto mb-12">
        <h2 className="text-choir-blue-dark text-3xl font-bold mb-4">
          Come Sing With Us!
        </h2>
        <p className="text-lg text-gray-700 max-w-2xl mx-auto">
          Experience the joy of singing together in a friendly, welcoming environment. No previous experience needed!
        </p>
      </section>
    </div>
  )
}
