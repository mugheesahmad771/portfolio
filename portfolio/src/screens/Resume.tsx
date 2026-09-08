import type { ReactNode } from "react";
import { Download, CheckCircle2 } from "lucide-react";
import { profile, experience, education, skillGroups } from "../../data/content";
import { Button } from "../../components/Button";
import { SectionHeader } from "../../components/SectionHeader";

export default function Resume() {
  return (
    <div>
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 pt-16 pb-10">
        <div className="flex flex-col sm:flex-row sm:items-end sm:justify-between gap-6">
          <SectionHeader
            eyebrow="Resume"
            title="Resume"
            description="A structured overview of my experience, skills and education. Download the PDF for a print-ready version."
          />
          <div className="shrink-0">
            <Button href="/resume.pdf" variant="primary">
              <Download size={18} strokeWidth={1.5} />
              Download PDF
            </Button>
          </div>
        </div>
      </section>

      {/* Resume document */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 pb-28">
        <div
          className="rounded-card bg-card border border-border overflow-hidden"
          style={{ boxShadow: "var(--shadow-md)" }}
        >
          {/* Document header */}
          <div
            className="px-8 lg:px-14 py-10 border-b border-divider"
            style={{ background: "linear-gradient(160deg, #0F172A 0%, #111827 100%)" }} /* ds-ok: brand hero gradient */
          >
            <h1 className="text-3xl lg:text-4xl font-bold text-heading tracking-tight">
              {profile.name}
            </h1>
            <p className="mt-2 text-lg text-primary font-semibold">{profile.title}</p>
            <div className="mt-4 flex flex-wrap gap-x-6 gap-y-2 text-sm text-muted font-mono">
              <span>{profile.email}</span>
              <span>{profile.phone}</span>
              <span>{profile.location}</span>
              <a href={profile.github} className="hover:text-primary transition-colors">
                github.com/mugheesahmad
              </a>
              <a href={profile.linkedin} className="hover:text-primary transition-colors">
                linkedin.com/in/mugheesahmad
              </a>
            </div>
          </div>

          <div className="px-8 lg:px-14 py-10 space-y-12">
            {/* Summary */}
            <DocSection title="Professional Summary">
              <p className="text-body leading-relaxed">{profile.summary}</p>
            </DocSection>

            {/* Experience */}
            <DocSection title="Experience">
              <div className="space-y-8">
                {experience.map((e) => (
                  <div key={`${e.company}-${e.role}`} className="border-l-2 border-divider pl-5">
                    <div className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-1">
                      <div>
                        <h4 className="text-base font-semibold text-heading">{e.role}</h4>
                        <p className="text-sm text-muted mt-0.5">{e.company} · {e.location}</p>
                      </div>
                      <div className="flex items-center gap-2 shrink-0">
                        <p className="font-mono text-sm text-primary">{e.duration}</p>
                        {e.current && (
                          <span className="inline-flex items-center gap-1 text-xs text-green">
                            <CheckCircle2 size={12} strokeWidth={2} /> Current
                          </span>
                        )}
                      </div>
                    </div>
                    <ul className="mt-4 space-y-2">
                      {e.responsibilities.map((r) => (
                        <li key={r} className="flex gap-2.5 text-sm text-body leading-relaxed">
                          <span className="w-1.5 h-1.5 rounded-full bg-primary mt-1.5 shrink-0" />
                          {r}
                        </li>
                      ))}
                    </ul>
                    <div className="mt-3 flex flex-wrap gap-1.5">
                      {e.technologies.map((t) => (
                        <span
                          key={t}
                          className="inline-flex items-center rounded-pill bg-card-2 border border-border text-body font-mono px-2.5 py-0.5 text-xs"
                        >
                          {t}
                        </span>
                      ))}
                    </div>
                  </div>
                ))}
              </div>
            </DocSection>

            {/* Skills */}
            <DocSection title="Skills">
              <div className="grid sm:grid-cols-2 lg:grid-cols-3 gap-4">
                {skillGroups.map((g) => (
                  <div key={g.category}>
                    <p className="font-mono text-xs uppercase tracking-widest text-disabled mb-2">
                      {g.category}
                    </p>
                    <p className="text-sm text-body">{g.skills.join(", ")}</p>
                  </div>
                ))}
              </div>
            </DocSection>

            {/* Education */}
            <DocSection title="Education">
              <div className="space-y-4">
                {education.map((e) => (
                  <div key={e.degree} className="flex flex-col sm:flex-row sm:items-start sm:justify-between gap-1">
                    <div>
                      <h4 className="text-base font-semibold text-heading">{e.degree}</h4>
                      <p className="text-sm text-muted mt-0.5">{e.school}</p>
                      {e.detail && <p className="text-sm text-body mt-1">{e.detail}</p>}
                    </div>
                    <p className="font-mono text-sm text-primary shrink-0">{e.duration}</p>
                  </div>
                ))}
              </div>
            </DocSection>
          </div>

          {/* Document footer with sticky download */}
          <div className="px-8 lg:px-14 py-6 border-t border-divider bg-bg-secondary flex flex-col sm:flex-row items-center justify-between gap-4">
            <p className="text-sm text-muted">
              {profile.availability}
            </p>
            <Button href="/resume.pdf" variant="secondary">
              <Download size={16} strokeWidth={1.5} />
              Download PDF
            </Button>
          </div>
        </div>
      </section>
    </div>
  );
}

function DocSection({ title, children }: { title: string; children: ReactNode }) {
  return (
    <div>
      <div className="flex items-center gap-4 mb-6">
        <p className="font-mono text-xs uppercase tracking-[0.2em] text-primary shrink-0">{title}</p>
        <div className="flex-1 h-px bg-divider" />
      </div>
      {children}
    </div>
  );
}
