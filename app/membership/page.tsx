export const metadata = {
  title: 'Membership | Chichester Community Choir',
  description: 'Information about joining our choir and membership fees',
}

export default function MembershipPage() {
  return (
    <div className="bg-gray-100 text-lg leading-relaxed">
      {/* Hero */}
      <section className="bg-choir-blue text-white py-12 text-center">
        <h1 className="text-5xl mb-4">Membership</h1>
        <p className="max-w-3xl mx-auto px-4">
          Join our choir community and help support our mission through your membership.
        </p>
      </section>

      {/* Membership Fees */}
      <section className="max-w-6xl mx-auto my-12 p-8 bg-white rounded-lg shadow-md">
        <h2 className="text-3xl text-choir-blue-dark text-center mb-6">Membership Fees</h2>
        <p className="text-center max-w-3xl mx-auto mb-4">
          Our choir is run as a non-profit organization, and membership fees help cover our essential costs.
          We strive to keep fees affordable while providing a high-quality choral experience.
        </p>
        <p className="text-center max-w-3xl mx-auto mb-8">
          Prospective members are welcome to join us for a rehearsal to get a feel for the choir before committing
          - no need to worry about payment until you decide to join.
        </p>

        <div className="max-w-3xl mx-auto bg-white border border-gray-200 rounded-lg shadow-md p-8 mb-8">
          <h3 className="text-2xl text-choir-blue text-center mb-4">Membership Information</h3>
          <div className="text-center mb-6 p-4 bg-gray-50 rounded">
            <span className="text-4xl font-bold text-choir-blue">£28</span>
            <span className="text-xl text-gray-600 ml-2">per month</span>
          </div>
          <p className="text-center text-gray-600 mb-6">
            Your membership includes access to all choir activities and resources. We aim to make music accessible
            to everyone while maintaining the quality of our performances.
          </p>
          <div className="mb-6">
            <h4 className="text-xl text-choir-blue mb-3">What&apos;s Included:</h4>
            <ul className="list-disc pl-6 text-gray-600">
              <li className="mb-2">Weekly rehearsals with professional direction</li>
              <li className="mb-2">All sheet music and practice materials provided</li>
              <li className="mb-2">Regular performance opportunities throughout the year</li>
              <li className="mb-2">Access to social events and choir community</li>
              <li>Online practice resources and recordings</li>
            </ul>
          </div>
        </div>

        <div className="bg-gray-50 rounded-lg p-6 mb-8">
          <h3 className="text-2xl text-choir-blue mb-4">Payment Options</h3>
          <ul className="list-disc pl-6 mb-4">
            <li className="mb-2">Please pay via bank transfer.</li>
            <li>Financial assistance available - please speak with Caroline in confidence</li>
          </ul>
          <p className="italic text-gray-600">
            Note: Membership fees are due on the 1st of each month.
          </p>
          <div className="mt-6 bg-choir-blue text-white p-6 rounded-lg text-center">
            <p className="font-bold text-xl mb-2">Payment Details</p>
            <p className="mb-1">Contact us for bank details:</p>
            <a href="mailto:caroline@chicommunitychoir.com" className="underline hover:text-gray-200 transition-colors">
              caroline@chicommunitychoir.com
            </a>
          </div>
        </div>
      </section>

      {/* Where Fees Go */}
      <section className="max-w-6xl mx-auto my-12 p-8 bg-white rounded-lg shadow-md">
        <h2 className="text-3xl text-choir-blue-dark text-center mb-6">Where Your Membership Fees Go</h2>
        <div className="text-center max-w-3xl mx-auto">
          <p className="mb-4">
            Your membership fees help keep the choir running smoothly! They cover essentials like sheet music,
            venue hire for rehearsals, insurance, and concert production costs.
          </p>
          <p>
            Want more details about how we use the funds? Just ask - we&apos;re always happy to chat about our
            financial management.
          </p>
        </div>
      </section>

      {/* FAQ */}
      <section className="max-w-6xl mx-auto my-12 p-8 bg-white rounded-lg shadow-md">
        <h2 className="text-3xl text-choir-blue-dark text-center mb-6">Frequently Asked Questions</h2>
        <div className="space-y-6">
          <FAQItem
            question="Can I try out the choir before committing to membership?"
            answer="Absolutely! We invite potential members to attend one of our rehearsals free of charge before making a decision about joining. This gives you an opportunity to meet current members and experience our rehearsal process."
          />
          <FAQItem
            question="Do I need prior singing experience to join?"
            answer="Not at all! We welcome singers of all experience levels. Our supportive environment and professional direction will help you develop your voice and musical skills. The only requirements are enthusiasm and a willingness to learn!"
          />
          <FAQItem
            question="What happens if I need to leave the choir mid-season?"
            answer="We understand that circumstances change. Monthly memberships can be canceled with 30 days' notice."
          />
          <FAQItem
            question="Do you offer any financial assistance programs?"
            answer="Yes, we have a limited financial assistance fund to help those who may be experiencing hardship. Applications are confidential and are reviewed by a small committee. Please speak with our treasurer for more information."
          />
        </div>
      </section>

      {/* Contact */}
      <section className="bg-choir-blue-dark text-white py-12 text-center">
        <h2 className="text-3xl mb-6">Questions About Membership?</h2>
        <p className="max-w-2xl mx-auto mb-6 px-4">
          If you have any questions about membership fees or payment options, feel free to get in touch!
        </p>
        <div>
          <p className="font-bold">Email</p>
          <p>caroline@chicommunitychoir.com</p>
        </div>
      </section>
    </div>
  )
}

function FAQItem({ question, answer }: { question: string; answer: string }) {
  return (
    <div className="border-b border-gray-200 pb-6">
      <h3 className="text-xl text-choir-blue mb-3">{question}</h3>
      <p className="text-gray-600">{answer}</p>
    </div>
  )
}
