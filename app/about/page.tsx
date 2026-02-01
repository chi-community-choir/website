import Image from 'next/image'
import type { Metadata } from 'next'
import { MusicalDivider } from '@/components/MusicalDivider'

export const metadata: Metadata = {
  title: 'About Us | Chichester Community Choir',
  description: 'Learn about the Chichester Community Choir, our directors, and our mission',
}

export default function AboutPage() {
  return (
    <div className="text-lg leading-relaxed">
      {/* Hero Section */}
      <section className="bg-gradient-to-br from-choir-blue via-choir-blue to-choir-blue-light text-white py-12 text-center mb-8 relative overflow-hidden">
        <div className="absolute inset-0 bg-[radial-gradient(circle_at_30%_50%,rgba(255,255,255,0.08),transparent_50%)]"></div>
        <div className="relative z-10">
          <h1 className="text-5xl mb-4">About Us</h1>
          <p className="max-w-3xl mx-auto text-xl px-4">
            Learn about the Chichester Community Choir, our directors, and our mission to bring people together through music.
          </p>
        </div>
      </section>

      {/* Directors Section */}
      <section className="max-w-6xl mx-auto p-8 bg-white rounded-lg shadow-warm-md border-2 border-choir-warm-gray">
        <h2 className="text-3xl mb-6 text-choir-blue-dark text-center">Our Directors</h2>
        <div className="flex flex-wrap gap-8 items-center">
          <div className="flex-1 min-w-[300px]">
            <Image
              src="https://flhaurczyt40eicf.public.blob.vercel-storage.com/images/Caroline-and-John-1.jpg"
              alt="Directors Caroline and John"
              width={600}
              height={800}
              className="w-full h-auto max-h-96 object-contain rounded-lg shadow-warm-md"
            />
          </div>
          <div className="flex-1 min-w-[400px] p-4">
            <p className="mb-6 text-lg">
              Both our choir leaders have extensive knowledge and years of experience in building fabulous vocal groups, and vast amounts of enthusiasm to get our local community singing!
            </p>
            <p className="mb-6 text-lg">
              Caroline and John bring a blend of classical training and contemporary approaches to choral direction, creating an inclusive and dynamic environment for singers of all levels.
            </p>
            <p className="text-lg">
              With backgrounds in music education and performance, they specialize in helping choir members develop their vocal skills while fostering a strong sense of community and enjoyment.
            </p>
          </div>
        </div>
      </section>

      <MusicalDivider variant='icon' image='treble-clef'/>

      {/* Choir Information */}
      <section className="max-w-6xl mx-auto p-8 bg-white rounded-lg shadow-warm-md border-2 border-choir-warm-gray">
        <h2 className="text-3xl mb-6 text-choir-blue-dark text-center">Our Choir</h2>
        <div className="max-w-4xl mx-auto">
          <p className="mb-6 text-lg text-center">
            Meeting every Tuesday evening from 6:45 PM to 8:15 PM, we provide singers with the opportunity to explore a wide variety of musical styles. We perform in rich harmony using SATB voice parts: from madrigals to mash-ups, rounds to rock and canons to classical.
          </p>
          <div className="flex flex-wrap gap-8 justify-center mt-8">
            <ChoirFeature
              title="Inclusive Environment"
              description="We welcome singers of all abilities, from beginners to experienced performers, in a supportive atmosphere."
            />
            <ChoirFeature
              title="Diverse Repertoire"
              description="Our performances span multiple genres and eras, ensuring there's something for everyone to enjoy."
            />
            <ChoirFeature
              title="Community Focused"
              description="Beyond making music, we build connections and friendships within our local community."
            />
          </div>
        </div>
      </section>

      <MusicalDivider image='alto-clef'/>

      {/* Rehearsal Information */}
      <section className="max-w-6xl mx-auto p-8 bg-white rounded-lg shadow-warm-md border-2 border-choir-warm-gray">
        <h2 className="text-3xl text-choir-blue-dark text-center mb-4">Rehearsal Information</h2>
        <div className="flex flex-wrap gap-4 justify-center">
          <div className="flex-1 min-w-[300px] p-8 bg-choir-peach-tint rounded-lg m-4 border border-choir-warm-gray">
            <h3 className="text-2xl mb-4 text-choir-blue">When & Where</h3>
            <p className="mb-4">
              Tuesday Evenings<br />
              6:45 PM - 8:15 PM
            </p>
            <p className="mb-6">
              University of Chichester<br />
              College Ln<br />
              PO19 6PF
            </p>
            <p>
              For details on how to join us, email:{' '}
              <a href="mailto:caroline@chicommunitychoir.com" className="text-choir-blue hover:text-choir-blue-light underline transition-colors">
                caroline@chicommunitychoir.com
              </a>
            </p>
          </div>
          <div className="flex-1 min-w-[300px] p-8 bg-choir-peach-tint rounded-lg m-4 border border-choir-warm-gray">
            <h3 className="text-2xl mb-4 text-choir-blue">What to Expect</h3>
            <ul className="list-disc pl-6">
              <li className="mb-2">Warm-up exercises to prepare your voice</li>
              <li className="mb-2">Section practice for each voice part</li>
              <li className="mb-2">Full ensemble work on current repertoire</li>
              <li className="mb-2">A mix of sight-reading and learning by ear</li>
              <li>Plenty of laughter and enjoyment!</li>
            </ul>
          </div>
        </div>
      </section>

      <MusicalDivider image='bass-clef'/>

      {/* History */}
      <section className="max-w-6xl mx-auto mb-12 p-8 bg-white rounded-lg shadow-warm-md border-2 border-choir-warm-gray">
        <h2 className="text-3xl mb-6 text-choir-blue-dark text-center">Our History</h2>
        <div className="max-w-3xl mx-auto">
          <p className="text-lg text-center">
            Chichester Community Choir was founded by Steve Flashman, who soon realised that not everyone could make it to evening rehearsals. He set up satellite daytime choirs to complement the CCC, which are now run by Caroline as Upbeat Singers, in Southbourne and East Preston. John also runs a daytime choir, the Ok Chorale.
          </p>
        </div>
      </section>

      {/* CTA */}
      <section className="bg-choir-blue-dark text-white py-12 text-center">
        <h2 className="text-3xl mb-6">Join Our Choir Family</h2>
        <p className="max-w-2xl mx-auto text-xl mb-6 px-4">
          No auditions required! We welcome singers of all experience levels who share our passion for music and community.
        </p>
        <a
          href="/membership"
          className="inline-block bg-choir-coral-dark text-white font-bold px-8 py-4 rounded-lg text-xl no-underline transition-all hover:bg-choir-coral-dark/90 focus:outline-none focus:ring-2 focus:ring-choir-coral-dark focus:ring-offset-2 focus:ring-offset-choir-blue-dark active:translate-y-[1px] shadow-warm-md"
        >
          Learn About Membership
        </a>
      </section>
    </div>
  )
}

function ChoirFeature({ title, description }: { title: string; description: string }) {
  return (
    <div className="bg-choir-peach-tint rounded-lg p-6 shadow-warm-sm w-64 max-w-full border border-choir-warm-gray">
      <h3 className="text-choir-blue text-xl mb-3 text-center">{title}</h3>
      <p className="text-gray-600 text-center text-base">{description}</p>
    </div>
  )
}
