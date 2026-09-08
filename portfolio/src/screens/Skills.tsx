import { skillGroups, techStack } from "../../data/content";
import { SectionHeader } from "../../components/SectionHeader";
import { TechChip } from "../../components/TechChip";

const categoryAccent: Record<string, string> = {
  Mobile: "text-primary bg-primary/10",
  Frontend: "text-purple bg-purple/10",
  Backend: "text-green bg-green/10",
  Database: "text-orange bg-orange/10",
  "Cloud & Services": "text-primary bg-primary/10",
  Tools: "text-muted bg-elevated/30",
};

export default function Skills() {
  return (
    <div>
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 pt-16 pb-20">
        <SectionHeader
          eyebrow="Capabilities"
          title="Skills"
          description="The technologies and disciplines I use to build production software — from mobile clients to APIs to cloud services."
        />

        <div className="mt-12 grid md:grid-cols-2 lg:grid-cols-3 gap-6">
          {skillGroups.map((group) => {
            const accent = categoryAccent[group.category] ?? "text-primary bg-primary/10";
            return (
              <div
                key={group.category}
                className="rounded-card bg-card border border-border p-6 lg:p-8 hover:border-primary transition-colors group"
                style={{ boxShadow: "var(--shadow-sm)" }}
              >
                <div className="flex items-center gap-3">
                  <span className={`inline-flex items-center justify-center w-8 h-8 rounded-[8px] text-xs font-mono font-semibold ${accent}`}>
                    {group.category.slice(0, 2).toUpperCase()}
                  </span>
                  <h3 className="text-base font-semibold text-heading">{group.category}</h3>
                </div>

                <div className="mt-5 space-y-2.5">
                  {group.skills.map((skill) => (
                    <div key={skill} className="flex items-center justify-between gap-4">
                      <span className="text-sm text-body">{skill}</span>
                      <div className="flex-1 max-w-[80px] h-1 rounded-full bg-divider overflow-hidden">
                        <div
                          className="h-full rounded-full bg-primary/40 group-hover:bg-primary/60 transition-colors"
                          style={{ width: "80%" }}
                        />
                      </div>
                    </div>
                  ))}
                </div>
              </div>
            );
          })}
        </div>
      </section>

      {/* Full stack strip */}
      <section className="border-t border-divider bg-bg-secondary">
        <div className="mx-auto max-w-[1440px] px-6 lg:px-16 py-12">
          <p className="font-mono text-xs uppercase tracking-[0.2em] text-disabled mb-6">
            Full stack at a glance
          </p>
          <div className="flex flex-wrap gap-3">
            {techStack.map((t) => (
              <TechChip key={t} label={t} />
            ))}
          </div>
        </div>
      </section>
    </div>
  );
}
