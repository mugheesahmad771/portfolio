import {
  Mail,
  Phone,
  MapPin,
  ArrowRight,
} from "lucide-react";
import { profile } from "../../data/content";
import { Button } from "../../components/Button";
import { SectionHeader } from "../../components/SectionHeader";

const contactMethods = [
  {
    icon: Mail,
    label: "Email",
    value: profile.email,
    href: `mailto:${profile.email}`,
    description: "Best way to reach me for project inquiries.",
  },
  {
    icon: Phone,
    label: "Phone",
    value: profile.phone,
    href: `tel:${profile.phone}`,
    description: "Available for calls during Pakistan business hours.",
  },
  {
    icon: MapPin,
    label: "Location",
    value: profile.location,
    href: null,
    description: "Open to remote roles worldwide.",
  },
  {
    icon: MapPin,
    label: "GitHub",
    value: "github.com/mugheesahmad",
    href: profile.github,
    description: "Browse my public repositories and contributions.",
  },
  {
    icon: MapPin,
    label: "LinkedIn",
    value: "linkedin.com/in/mugheesahmad",
    href: profile.linkedin,
    description: "Connect professionally or view my full profile.",
  },
];

export default function Contact() {
  return (
    <div>
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 pt-16 pb-20">
        <SectionHeader
          eyebrow="Get in touch"
          title="Let's work together"
          description="I'm open to senior full-stack and mobile roles — remote, worldwide. Whether you have a project in mind or just want to connect, I'd love to hear from you."
        />

        <div className="mt-12 grid sm:grid-cols-2 lg:grid-cols-3 gap-5">
          {contactMethods.map((method) => {
            const Icon = method.icon;
            const inner = (
              <>
                <span className="inline-flex items-center justify-center w-10 h-10 rounded-[10px] bg-primary/10 text-primary shrink-0">
                  <Icon size={20} strokeWidth={1.5} />
                </span>
                <div className="min-w-0">
                  <p className="font-mono text-xs uppercase tracking-widest text-disabled">{method.label}</p>
                  <p className="mt-1 text-sm font-semibold text-heading truncate">{method.value}</p>
                  <p className="mt-1 text-xs text-muted">{method.description}</p>
                </div>
              </>
            );

            const cardCls =
              "flex items-start gap-4 rounded-card bg-card border border-border p-6 hover:border-primary transition-colors";

            if (method.href) {
              return (
                <a
                  key={method.label}
                  href={method.href}
                  target={method.href.startsWith("http") ? "_blank" : undefined}
                  rel={method.href.startsWith("http") ? "noopener noreferrer" : undefined}
                  className={cardCls}
                  style={{ boxShadow: "var(--shadow-sm)" }}
                >
                  {inner}
                </a>
              );
            }

            return (
              <div
                key={method.label}
                className={cardCls}
                style={{ boxShadow: "var(--shadow-sm)" }}
              >
                {inner}
              </div>
            );
          })}
        </div>
      </section>

      {/* CTA panel */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 pb-28">
        <div
          className="relative rounded-card border border-border overflow-hidden px-8 lg:px-16 py-16 lg:py-20 text-center"
          style={{ background: "linear-gradient(160deg, #0F172A 0%, #111827 100%)" }} /* ds-ok: brand hero gradient */
        >
          <p className="font-mono text-xs uppercase tracking-[0.2em] text-primary">
            Open to opportunities
          </p>
          <h2 className="mt-5 text-3xl lg:text-5xl font-semibold text-heading tracking-tight max-w-3xl mx-auto leading-tight">
            Ready to contribute from day one.
          </h2>
          <p className="mt-5 text-base text-muted max-w-xl mx-auto">
            {profile.relocation} Available for select remote roles worldwide.
          </p>
          <div className="mt-9 flex flex-wrap items-center justify-center gap-4">
            <Button href={`mailto:${profile.email}`}>
              Hire Me <ArrowRight size={18} strokeWidth={1.5} />
            </Button>
            <Button href={profile.linkedin} variant="secondary">
              <MapPin size={18} strokeWidth={1.5} />
              LinkedIn
            </Button>
          </div>
        </div>
      </section>
    </div>
  );
}
