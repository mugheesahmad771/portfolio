import {
  Smartphone,
  Zap,
  Code2,
  LayoutDashboard,
  GraduationCap,
} from "lucide-react";
import { profile, education, values } from "../../data/content";
import { SectionHeader } from "../../components/SectionHeader";

const highlights = [
  {
    icon: Smartphone,
    title: "Published iOS & Android apps",
    detail:
      "Shipped production Flutter apps to both the App Store and Google Play — live, real users, real reviews. End-to-end ownership from architecture to store submission.",
  },
  {
    icon: Zap,
    title: "Enterprise EV charging platform",
    detail:
      "Led mobile delivery for a national EV charging network: real-time station maps, in-app reservations, payments, and live session monitoring across iOS, Android and Web.",
  },
  {
    icon: Code2,
    title: "ASP.NET Core Web APIs",
    detail:
      "Designed and built the shared API layer powering both mobile clients and Angular dashboards — JWT auth, typed models, SQL Server, and clean separation of concerns.",
  },
  {
    icon: LayoutDashboard,
    title: "Angular enterprise dashboards",
    detail:
      "Built operator-facing dashboards with live KPI cards, filterable session tables, role-based access and exportable reports on top of shared API contracts.",
  },
];

export default function About() {
  return (
    <div>
      {/* Summary */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 pt-16 pb-20">
        <div className="grid lg:grid-cols-[1.2fr_0.8fr] gap-16 items-start">
          <div>
            <SectionHeader
              eyebrow="About"
              title="Senior Full Stack Developer"
              description={profile.summary}
            />
            <div className="mt-10 space-y-5 text-body leading-relaxed text-[17px]">
              <p>
                I started as a generalist — picking up Flutter and React Native while simultaneously
                learning how to wire up REST APIs and manage SQL Server schemas. Those early years
                at HBit Technology were a crash course in full-stack ownership: no handoffs, no
                silos. If a feature needed a new endpoint, I built it. If the mobile UI needed
                polish, I polished it. That breadth became the foundation everything else is built on.
              </p>
              <p>
                Over time I moved into leading mobile delivery for enterprise-grade products — most
                notably a national EV charging platform that ships to real users on iOS and Android.
                That role sharpened my instincts around production reliability, NDA-safe client
                work, and the discipline of owning a release pipeline from first commit to store
                approval. I write code that teams can maintain, APIs that mobile clients can trust,
                and dashboards that operators actually use.
              </p>
            </div>
          </div>

          {/* Quick facts panel */}
          <div
            className="rounded-card border border-border p-8 space-y-6"
            style={{ boxShadow: "var(--shadow-md)" }}
          >
            <p className="font-mono text-xs uppercase tracking-[0.2em] text-primary">Quick facts</p>
            <div className="space-y-4">
              {[
                { label: "Location", value: profile.location },
                { label: "Experience", value: profile.experience },
                { label: "Current company", value: profile.company },
                { label: "Availability", value: profile.availability },
                { label: "Relocation", value: profile.relocation },
              ].map((f) => (
                <div key={f.label} className="border-b border-divider pb-4 last:border-0 last:pb-0">
                  <p className="font-mono text-xs uppercase tracking-widest text-disabled">{f.label}</p>
                  <p className="mt-1.5 text-sm text-title">{f.value}</p>
                </div>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* Highlights */}
      <section className="bg-section border-y border-divider">
        <div className="mx-auto max-w-[1440px] px-6 lg:px-16 py-20">
          <SectionHeader
            eyebrow="Highlights"
            title="What I've shipped"
            description="A few of the production systems I've built and owned end to end."
          />
          <div className="mt-12 grid sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {highlights.map((h) => {
              const Icon = h.icon;
              return (
                <div
                  key={h.title}
                  className="rounded-card bg-card border border-border p-6 hover:border-primary transition-colors"
                  style={{ boxShadow: "var(--shadow-sm)" }}
                >
                  <span className="inline-flex items-center justify-center w-10 h-10 rounded-[10px] bg-primary/10 text-primary">
                    <Icon size={20} strokeWidth={1.5} />
                  </span>
                  <h3 className="mt-5 text-base font-semibold text-heading leading-snug">{h.title}</h3>
                  <p className="mt-3 text-sm text-muted leading-relaxed">{h.detail}</p>
                </div>
              );
            })}
          </div>
        </div>
      </section>

      {/* Education */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 py-20">
        <SectionHeader eyebrow="Education" title="Academic background" />
        <div className="mt-12 space-y-4">
          {education.map((e) => (
            <div
              key={e.degree}
              className="flex flex-col lg:flex-row lg:items-center gap-4 lg:gap-10 rounded-card bg-card border border-border p-6 lg:p-8"
              style={{ boxShadow: "var(--shadow-sm)" }}
            >
              <span className="inline-flex items-center justify-center w-12 h-12 rounded-[12px] bg-purple/10 text-purple shrink-0">
                <GraduationCap size={22} strokeWidth={1.5} />
              </span>
              <div className="flex-1">
                <h3 className="text-lg font-semibold text-heading">{e.degree}</h3>
                <p className="mt-1 text-sm text-muted">{e.school}</p>
                {e.detail && <p className="mt-2 text-sm text-body">{e.detail}</p>}
              </div>
              <p className="font-mono text-sm text-primary shrink-0">{e.duration}</p>
            </div>
          ))}
        </div>
      </section>

      {/* Values */}
      <section className="bg-section border-t border-divider">
        <div className="mx-auto max-w-[1440px] px-6 lg:px-16 py-20">
          <SectionHeader
            eyebrow="Principles"
            title="How I work"
            description="The convictions that shape how I approach every project."
          />
          <div className="mt-12 grid sm:grid-cols-2 lg:grid-cols-4 gap-6">
            {values.map((v, i) => (
              <div
                key={v.title}
                className="rounded-card bg-card border border-border p-6 hover:border-primary transition-colors"
                style={{ boxShadow: "var(--shadow-sm)" }}
              >
                <p className="font-mono text-xs text-disabled">0{i + 1}</p>
                <h3 className="mt-4 text-base font-semibold text-heading">{v.title}</h3>
                <p className="mt-3 text-sm text-muted leading-relaxed">{v.detail}</p>
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}
