import { Link } from "react-router-dom";
import {
  ArrowRight,
  Download,MapPin,
  CheckCircle2,
  Smartphone,
  ArrowUpRight,
} from "lucide-react";
import { profile, stats, techStack, projects, experience } from "../../data/content";
import { Button } from "../../components/Button";
import { TechChip } from "../../components/TechChip";
import { Badge } from "../../components/Badge";
import { SectionHeader } from "../../components/SectionHeader";
import { ProjectCard } from "../../components/ProjectCard";

const featured = projects.filter((p) => p.featured);

export default function Home() {
  return (
    <div>
      {/* Hero */}
      <section className="relative overflow-hidden">
        <div className="mx-auto max-w-[1440px] px-6 lg:px-16 pt-16 pb-24 lg:pt-24 lg:pb-32">
          <div className="grid lg:grid-cols-[1.15fr_0.85fr] gap-16 items-center">
            <div>
              <div className="anim-fade-up" style={{ animationDelay: "0ms" }}>
                <Badge tone="open" dot>
                  {profile.availability}
                </Badge>
              </div>
              <h1
                className="anim-fade-up mt-7 text-5xl lg:text-[64px] leading-[1.02] font-bold text-heading tracking-tight"
                style={{ animationDelay: "80ms" }}
              >
                {profile.name}
              </h1>
              <p
                className="anim-fade-up mt-4 text-2xl lg:text-[26px] font-semibold text-primary tracking-tight"
                style={{ animationDelay: "160ms" }}
              >
                {profile.title}
              </p>
              <p
                className="anim-fade-up mt-6 max-w-xl text-lg text-muted leading-relaxed"
                style={{ animationDelay: "240ms" }}
              >
                {profile.tagline}
              </p>
              <div
                className="anim-fade-up mt-7 flex flex-wrap gap-3"
                style={{ animationDelay: "320ms" }}
              >
                {profile.specialization.map((s) => (
                  <TechChip key={s} label={s} />
                ))}
              </div>
              <div
                className="anim-fade-up mt-9 flex flex-wrap items-center gap-4"
                style={{ animationDelay: "400ms" }}
              >
                <Button to="/projects">
                  View Projects <ArrowRight size={18} strokeWidth={1.5} />
                </Button>
                <Button variant="secondary" to="/resume">
                  <Download size={18} strokeWidth={1.5} /> Download Resume
                </Button>
                <a
                  href={profile.github}
                  aria-label="GitHub"
                  className="grid place-items-center w-12 h-12 rounded-btn border border-border text-muted hover:text-heading hover:border-primary transition-colors"
                >
                  <MapPin size={20} strokeWidth={1.5} />
                </a>
                <a
                  href={profile.linkedin}
                  aria-label="LinkedIn"
                  className="grid place-items-center w-12 h-12 rounded-btn border border-border text-muted hover:text-heading hover:border-primary transition-colors"
                >
                  <MapPin size={20} strokeWidth={1.5} />
                </a>
              </div>
            </div>

            {/* Portrait */}
            <div className="anim-fade-in relative" style={{ animationDelay: "300ms" }}>
              <div
                className="relative mx-auto w-full max-w-sm aspect-[4/5] rounded-img border border-border overflow-hidden flex items-end justify-center"
                style={{
                  background: "linear-gradient(160deg, #1E293B 0%, #111827 100%)",
                  boxShadow: "var(--shadow-lg)",
                }}
              >
                <div
                  className="w-3/5 h-4/5 rounded-t-full"
                  style={{ background: "linear-gradient(180deg, #334155 0%, #1E293B 100%)" }}
                />
              </div>
              <div
                className="absolute -bottom-5 left-4 flex items-center gap-3 rounded-input bg-card border border-border px-4 py-3"
                style={{ boxShadow: "var(--shadow-md)" }}
              >
                <span className="grid place-items-center w-9 h-9 rounded-[10px] bg-green/15 text-green">
                  <Smartphone size={18} strokeWidth={1.5} />
                </span>
                <div>
                  <p className="text-sm font-semibold text-heading">Apps live on stores</p>
                  <p className="text-xs text-muted font-mono">iOS · Android · Web</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {/* Tech stack strip */}
      <section className="border-y border-divider bg-bg-secondary">
        <div className="mx-auto max-w-[1440px] px-6 lg:px-16 py-8">
          <div className="flex flex-col lg:flex-row lg:items-center gap-6">
            <p className="font-mono text-xs uppercase tracking-[0.2em] text-disabled shrink-0">
              Core stack
            </p>
            <div className="flex flex-wrap gap-x-8 gap-y-3">
              {techStack.map((t) => (
                <span key={t} className="text-sm text-body font-mono">
                  {t}
                </span>
              ))}
            </div>
          </div>
        </div>
      </section>

      {/* Stats */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 py-20">
        <div className="grid grid-cols-2 lg:grid-cols-4 gap-px bg-divider rounded-card overflow-hidden border border-border">
          {stats.map((s) => (
            <div key={s.label} className="bg-card p-8">
              <div className="text-3xl lg:text-4xl font-semibold text-heading tracking-tight">
                {s.value}
              </div>
              <div className="mt-2 text-sm text-muted">{s.label}</div>
            </div>
          ))}
        </div>
      </section>

      {/* Featured projects */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 py-12">
        <div className="flex items-end justify-between gap-6">
          <SectionHeader
            eyebrow="Selected work"
            title="Featured projects"
            description="Production apps shipped to real users — including enterprise work shown NDA-safe."
          />
          <Link
            to="/projects"
            className="hidden sm:inline-flex items-center gap-1.5 text-sm text-primary hover:text-primary-hover transition-colors shrink-0"
          >
            All projects <ArrowUpRight size={16} strokeWidth={1.5} />
          </Link>
        </div>
        <div className="mt-12 grid md:grid-cols-2 gap-6">
          {featured.map((p) => (
            <ProjectCard key={p.id} project={p} />
          ))}
        </div>
      </section>

      {/* Experience preview */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 py-20">
        <SectionHeader eyebrow="Track record" title="Where I've been building" />
        <div className="mt-12 space-y-4">
          {experience.map((e) => (
            <div
              key={e.role}
              className="flex flex-col lg:flex-row lg:items-center gap-4 lg:gap-8 rounded-card bg-card border border-border p-6 hover:border-elevated transition-colors"
            >
              <div className="lg:w-40 shrink-0">
                <p className="font-mono text-sm text-primary">{e.duration}</p>
                {e.current && (
                  <span className="mt-2 inline-flex items-center gap-1 text-xs text-green">
                    <CheckCircle2 size={12} strokeWidth={2} /> Current
                  </span>
                )}
              </div>
              <div className="flex-1">
                <h3 className="text-lg font-semibold text-heading">{e.role}</h3>
                <p className="text-sm text-muted">{e.company} · {e.location}</p>
              </div>
              <div className="flex flex-wrap gap-2 lg:justify-end lg:max-w-xs">
                {e.technologies.slice(0, 3).map((t) => (
                  <TechChip key={t} label={t} size="sm" />
                ))}
              </div>
            </div>
          ))}
        </div>
        <div className="mt-8">
          <Button variant="ghost" to="/experience">
            Full experience <ArrowRight size={16} strokeWidth={1.5} />
          </Button>
        </div>
      </section>

      {/* Final CTA */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 pb-28">
        <div
          className="relative rounded-card border border-border overflow-hidden px-8 lg:px-16 py-16 lg:py-20 text-center"
          style={{ background: "linear-gradient(160deg, #0F172A 0%, #111827 100%)" }}
        >
          <p className="font-mono text-xs uppercase tracking-[0.2em] text-primary">
            Open to opportunities
          </p>
          <h2 className="mt-5 text-3xl lg:text-5xl font-semibold text-heading tracking-tight max-w-3xl mx-auto leading-tight">
            Ready to contribute to your engineering team from day one.
          </h2>
          <p className="mt-5 text-base text-muted max-w-xl mx-auto">
            {profile.relocation}
          </p>
          <div className="mt-9 flex flex-wrap items-center justify-center gap-4">
            <Button to="/contact">
              Hire Me <ArrowRight size={18} strokeWidth={1.5} />
            </Button>
            <Button variant="secondary" to="/resume">
              <Download size={18} strokeWidth={1.5} /> Download Resume
            </Button>
          </div>
        </div>
      </section>
    </div>
  );
}
