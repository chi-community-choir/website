import Image from 'next/image'

export default function HeroSection() {
  return (
    <section className="py-8">
      <div className="max-w-7xl mx-auto px-4">
        <div className="bg-gray-200 rounded-lg overflow-hidden">
          <Image
            src="https://flhaurczyt40eicf.public.blob.vercel-storage.com/images/2019-12-13-Choir-Header-1.png"
            alt="Chichester Community Choir banner"
            className="w-full h-auto shadow-warm-md"
            priority
          />
        </div>
      </div>
    </section>
  )
}
