import { CheckCircle2 } from "lucide-react";
import { experience } from "../../data/content";
import { TechChip } from "../../components/TechChip";
import { SectionHeader } from "../../components/SectionHeader";

export default function Experience() {
  return (
    <div>
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 pt-16 pb-28">
        <SectionHeader
          eyebrow="Career"
          title="Experience"
          description="A focused track record building and shipping production software at a single company — growing from full-stack contributor to leading enterprise mobile delivery."
        />

        <div className="mt-16 relative">
          {/* Vertical spine */}
          <div className="absolute left-[7px] top-2 bottom-2 w-px bg-divider hidden lg:block" />

          <div className="space-y-10">
            {experience.map((e, idx) => (
              <div key={`${e.company}-${e.role}`} className="relative flex gap-8">
                {/* Timeline dot */}
                <div className="hidden lg:flex flex-col items-center shrink-0 pt-1">
                  <span
                    className={`w-[15px] h-[15px] rounded-full border-2 shrink-0 z-10 ${
                      e.current
                        ? "bg-green border-green"
                        : "bg-bg border-border"
                    }`}
                  />
                </div>

                {/* Card */}
                <div
                  className="flex-1 rounded-card bg-card border border-border p-6 lg:p-8 hover:border-elevated transition-colors"
                  style={{ boxShadow: "var(--shadow-sm)" }}
                >
                  <div className="flex flex-col lg:flex-row lg:items-start lg:justify-between gap-4">
                    <div>
                      <div className="flex flex-wrap items-center gap-3">
                        <p className="font-mono text-sm text-primary">{e.duration}</p>
                        {e.current && (
                          <span className="inline-flex items-center gap-1.5 text-xs text-green font-medium">
                            <CheckCircle2 size={13} strokeWidth={2} />
                            Current
                          </span>
                        )}
                      </div>
                      <h3 className="mt-3 text-xl font-semibold text-heading tracking-tight">
                        {e.role}
                      </h3>
                      <p className="mt-1 text-sm text-muted">
                        {e.company} · {e.location}
                      </p>
                    </div>
                    {idx === 0 && (
                      <span className="inline-flex items-center rounded-pill border border-green/30 bg-green/10 text-green text-xs font-medium px-3 py-1 shrink-0">
                        Lead role
                      </span>
                    )}
                  </div>

                  {/* Responsibilities */}
                  <ul className="mt-6 space-y-3">
                    {e.responsibilities.map((r) => (
                      <li key={r} className="flex gap-3 text-body text-[15px] leading-relaxed">
                        <span className="w-1.5 h-1.5 rounded-full bg-primary mt-2 shrink-0" />
                        {r}
                      </li>
                    ))}
                  </ul>

                  {/* Tech chips */}
                  <div className="mt-6 flex flex-wrap gap-2">
                    {e.technologies.map((t) => (
                      <TechChip key={t} label={t} size="sm" />
                    ))}
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}
