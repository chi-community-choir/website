import Image from 'next/image'

export default function HeroSection() {
  return (
    <section className="py-8">
      <div className="max-w-7xl mx-auto px-4">
        <Image
          src="https://flhaurczyt40eicf.public.blob.vercel-storage.com/images/2019-12-13-Choir-Header-1.png"
          alt="Chichester Community Choir banner"
          className="rounded-lg w-full h-auto shadow-md"
        />
      </div>
    </section>
  )
}
