import { Link, useParams } from "react-router-dom";
import {
  ArrowLeft,
  Lock,
  ExternalLink,
  Smartphone,
  Globe,
  Apple,
  ImageOff,
  Check, MapPin,
} from "lucide-react";
import { projects } from "../../data/content";
import { TechChip } from "../../components/TechChip";
import { Badge } from "../../components/Badge";
import { ProjectCard } from "../../components/ProjectCard";

const platformIcon: Record<string, typeof Globe> = {
  Android: Smartphone,
  iOS: Apple,
  Web: Globe,
};

export default function ProjectDetails() {
  const { slug } = useParams<{ slug: string }>();
  const project = projects.find((p) => p.slug === slug);

  if (!project) {
    return (
      <div className="mx-auto max-w-[1440px] px-6 lg:px-16 py-32 text-center">
        <p className="text-title text-lg">Project not found.</p>
        <Link to="/projects" className="mt-4 inline-block text-primary hover:text-primary-hover">
          Back to projects
        </Link>
      </div>
    );
  }

  const company = project.canShowCompanyName ? project.company : "Confidential client";
  const showShots = project.canShowScreenshots;
  const related = projects.filter((p) => p.slug !== project.slug).slice(0, 3);

  return (
    <div>
      {/* Hero */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 pt-10 pb-14">
        <Link
          to="/projects"
          className="inline-flex items-center gap-2 text-sm text-muted hover:text-title transition-colors"
        >
          <ArrowLeft size={16} strokeWidth={1.5} /> All projects
        </Link>

        <div className="mt-8 flex flex-wrap items-center gap-2">
          {project.featured && <Badge tone="featured">Featured</Badge>}
          {project.privateProject && (
            <Badge tone="private">
              <Lock size={11} strokeWidth={2} /> NDA protected
            </Badge>
          )}
          {project.currentlyWorking && <Badge tone="open" dot>Ongoing</Badge>}
        </div>

        <h1 className="mt-6 text-4xl lg:text-5xl font-bold text-heading tracking-tight max-w-3xl">
          {project.title}
        </h1>
        <p className="mt-4 text-lg text-muted max-w-2xl leading-relaxed">
          {project.shortDescription}
        </p>

        <div className="mt-8 flex flex-wrap gap-x-10 gap-y-4">
          <Meta label="Role" value={project.role} />
          <Meta label="Company" value={company as string} />
          <Meta label="Duration" value={project.duration} />
          <Meta label="Timeline" value={`${project.startDate} — ${project.endDate ?? "Present"}`} />
        </div>

        <div className="mt-8 flex flex-wrap items-center gap-4">
          {project.playStoreUrl && (
            <a href={project.playStoreUrl} className="inline-flex items-center gap-2 text-sm text-primary hover:text-primary-hover">
              <Smartphone size={16} strokeWidth={1.5} /> Google Play
            </a>
          )}
          {project.appStoreUrl && (
            <a href={project.appStoreUrl} className="inline-flex items-center gap-2 text-sm text-primary hover:text-primary-hover">
              <Apple size={16} strokeWidth={1.5} /> App Store
            </a>
          )}
          {project.githubUrl && (
            <a href={project.githubUrl} className="inline-flex items-center gap-2 text-sm text-primary hover:text-primary-hover">
              <MapPin size={16} strokeWidth={1.5} /> Source
            </a>
          )}
          {project.liveUrl && (
            <a href={project.liveUrl} className="inline-flex items-center gap-2 text-sm text-primary hover:text-primary-hover">
              <ExternalLink size={16} strokeWidth={1.5} /> Live
            </a>
          )}
        </div>
      </section>

      {/* Cover / gallery OR metrics-only */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16">
        {showShots && project.coverImage ? (
          <div className="rounded-img overflow-hidden border border-border">
            <img src={project.coverImage} alt={project.title} className="w-full aspect-[16/9] object-cover" />
          </div>
        ) : (
          <div
            className="rounded-card border border-border p-10 lg:p-14"
            style={{ background: "linear-gradient(160deg, #0F172A 0%, #111827 100%)" }}
          >
            <div className="flex items-center gap-2 text-muted">
              <ImageOff size={16} strokeWidth={1.5} />
              <span className="font-mono text-xs uppercase tracking-widest">
                Screenshots under NDA — showing measurable impact instead
              </span>
            </div>
            <div className="mt-8 grid sm:grid-cols-3 gap-8">
              {project.statistics.map((s) => (
                <div key={s.label}>
                  <div className="text-4xl font-semibold text-heading tracking-tight">{s.value}</div>
                  <div className="mt-2 text-sm text-muted">{s.label}</div>
                </div>
              ))}
            </div>
          </div>
        )}
      </section>

      {/* Body */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 py-16">
        <div className="grid lg:grid-cols-[1.6fr_1fr] gap-14">
          <div className="space-y-12">
            <Block title="Overview" body={project.fullDescription} />
            <Block title="The problem" body={project.problemStatement} />
            <Block title="The solution" body={project.solution} />

            <div>
              <h3 className="font-mono text-xs uppercase tracking-[0.2em] text-primary">
                Responsibilities
              </h3>
              <ul className="mt-5 space-y-3">
                {project.responsibilities.map((r) => (
                  <li key={r} className="flex gap-3 text-body leading-relaxed">
                    <Check size={18} strokeWidth={2} className="text-primary shrink-0 mt-0.5" />
                    {r}
                  </li>
                ))}
              </ul>
            </div>

            {showShots && project.screenshots.length > 0 && (
              <div>
                <h3 className="font-mono text-xs uppercase tracking-[0.2em] text-primary">
                  Screenshots
                </h3>
                <div className="mt-5 grid sm:grid-cols-2 gap-4">
                  {project.screenshots.map((s, i) => (
                    <div key={i} className="rounded-img overflow-hidden border border-border">
                      <img src={s} alt={`${project.title} ${i + 1}`} loading="lazy" className="w-full aspect-[4/3] object-cover" />
                    </div>
                  ))}
                </div>
              </div>
            )}
          </div>

          {/* Sidebar */}
          <aside className="space-y-8">
            <div className="rounded-card bg-card border border-border p-6">
              <h3 className="font-mono text-xs uppercase tracking-[0.2em] text-disabled">
                Technology
              </h3>
              <div className="mt-4 flex flex-wrap gap-2">
                {project.technologies.map((t) => (
                  <TechChip key={t} label={t} size="sm" />
                ))}
              </div>
            </div>

            <div className="rounded-card bg-card border border-border p-6">
              <h3 className="font-mono text-xs uppercase tracking-[0.2em] text-disabled">
                Platforms
              </h3>
              <div className="mt-4 space-y-3">
                {project.platforms.map((p) => {
                  const Icon = platformIcon[p] ?? Globe;
                  return (
                    <div key={p} className="flex items-center gap-3 text-body">
                      <Icon size={18} strokeWidth={1.5} className="text-primary" />
                      {p}
                    </div>
                  );
                })}
              </div>
            </div>

            <div className="rounded-card bg-card border border-border p-6">
              <h3 className="font-mono text-xs uppercase tracking-[0.2em] text-disabled">
                Key features
              </h3>
              <ul className="mt-4 space-y-2.5">
                {project.keyFeatures.map((f) => (
                  <li key={f} className="text-sm text-body flex gap-2">
                    <span className="w-1.5 h-1.5 rounded-full bg-primary mt-1.5 shrink-0" />
                    {f}
                  </li>
                ))}
              </ul>
            </div>
          </aside>
        </div>
      </section>

      {/* Related */}
      <section className="mx-auto max-w-[1440px] px-6 lg:px-16 pb-24">
        <h2 className="text-2xl font-semibold text-heading tracking-tight">Related projects</h2>
        <div className="mt-8 grid md:grid-cols-3 gap-6">
          {related.map((p) => (
            <ProjectCard key={p.id} project={p} />
          ))}
        </div>
      </section>
    </div>
  );
}

function Meta({ label, value }: { label: string; value: string }) {
  return (
    <div>
      <p className="font-mono text-xs uppercase tracking-widest text-disabled">{label}</p>
      <p className="mt-1.5 text-title font-medium">{value}</p>
    </div>
  );
}

function Block({ title, body }: { title: string; body: string }) {
  return (
    <div>
      <h3 className="font-mono text-xs uppercase tracking-[0.2em] text-primary">{title}</h3>
      <p className="mt-4 text-body leading-relaxed text-[17px]">{body}</p>
    </div>
  );
}
