import { useState } from "react";
import type { ReactNode } from "react";
import { Link } from "react-router-dom";
import {
  ArrowLeft,
  ArrowUpRight,
  Save,
  CheckCircle2,
} from "lucide-react";

// ─── Toggle switch ────────────────────────────────────────────────────────────
function Toggle({
  checked,
  onChange,
  id,
}: {
  checked: boolean;
  onChange: (v: boolean) => void;
  id: string;
}) {
  return (
    <button
      type="button"
      id={id}
      role="switch"
      aria-checked={checked}
      onClick={() => onChange(!checked)}
      className={`relative inline-flex h-6 w-11 shrink-0 rounded-pill border-2 transition-colors focus:outline-none ${
        checked ? "bg-primary border-primary" : "bg-elevated border-border"
      }`}
    >
      <span
        className={`inline-block h-4 w-4 rounded-full bg-heading shadow transition-transform mt-[1px] ${
          checked ? "translate-x-5" : "translate-x-0.5"
        }`}
      />
    </button>
  );
}

// ─── Reusable field components ────────────────────────────────────────────────
function Label({ htmlFor, children }: { htmlFor?: string; children: ReactNode }) {
  return (
    <label htmlFor={htmlFor} className="block text-sm font-medium text-title mb-1.5">
      {children}
    </label>
  );
}

const inputCls =
  "w-full h-12 rounded-input bg-card border border-border px-4 text-sm text-title placeholder:text-disabled focus:outline-none focus:border-primary transition-colors";

const textareaCls =
  "w-full rounded-input bg-card border border-border px-4 py-3 text-sm text-title placeholder:text-disabled focus:outline-none focus:border-primary transition-colors resize-none";

function Field({
  label,
  id,
  children,
}: {
  label: string;
  id: string;
  children: ReactNode;
}) {
  return (
    <div>
      <Label htmlFor={id}>{label}</Label>
      {children}
    </div>
  );
}

function FormSection({
  title,
  children,
  highlight,
}: {
  title: string;
  children: ReactNode;
  highlight?: boolean;
}) {
  return (
    <div
      className={`rounded-card border p-6 lg:p-8 space-y-5 ${
        highlight
          ? "border-primary/40 bg-primary/5"
          : "border-border bg-card"
      }`}
      style={{ boxShadow: "var(--shadow-sm)" }}
    >
      <p className="font-mono text-xs uppercase tracking-[0.2em] text-primary">{title}</p>
      {children}
    </div>
  );
}

// ─── Admin top bar ────────────────────────────────────────────────────────────
function AdminBar() {
  return (
    <header className="h-14 border-b border-divider bg-bg-secondary flex items-center justify-between px-6 shrink-0">
      <span className="font-mono text-sm font-semibold text-heading tracking-tight">
        MA · Admin
      </span>
      <Link
        to="/"
        className="inline-flex items-center gap-1.5 text-sm text-muted hover:text-title transition-colors"
      >
        View site <ArrowUpRight size={15} strokeWidth={1.5} />
      </Link>
    </header>
  );
}

// ─── Main component ───────────────────────────────────────────────────────────
interface FormState {
  title: string;
  slug: string;
  role: string;
  company: string;
  client: string;
  employmentType: string;
  duration: string;
  startDate: string;
  endDate: string;
  currentlyWorking: boolean;
  shortDescription: string;
  fullDescription: string;
  problemStatement: string;
  solution: string;
  responsibilities: string;
  keyFeatures: string;
  technologies: string;
  platformAndroid: boolean;
  platformIOS: boolean;
  platformWeb: boolean;
  thumbnail: string;
  coverImage: string;
  githubUrl: string;
  liveUrl: string;
  playStoreUrl: string;
  appStoreUrl: string;
  featured: boolean;
  privateProject: boolean;
  canShowScreenshots: boolean;
  canShowCompanyName: boolean;
}

const defaultForm: FormState = {
  title: "",
  slug: "",
  role: "",
  company: "",
  client: "",
  employmentType: "Full-time",
  duration: "",
  startDate: "",
  endDate: "",
  currentlyWorking: false,
  shortDescription: "",
  fullDescription: "",
  problemStatement: "",
  solution: "",
  responsibilities: "",
  keyFeatures: "",
  technologies: "",
  platformAndroid: false,
  platformIOS: false,
  platformWeb: false,
  thumbnail: "",
  coverImage: "",
  githubUrl: "",
  liveUrl: "",
  playStoreUrl: "",
  appStoreUrl: "",
  featured: false,
  privateProject: false,
  canShowScreenshots: true,
  canShowCompanyName: true,
};

export default function AdminCreate() {
  const [form, setForm] = useState<FormState>(defaultForm);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);

  function set<K extends keyof FormState>(key: K, value: FormState[K]) {
    setForm((prev) => ({ ...prev, [key]: value }));
    setSaved(false);
  }

  function doSave() {
    setSaving(true);
    setTimeout(() => {
      setSaving(false);
      setSaved(true);
    }, 1200);
  }

  function handleSave(e: { preventDefault(): void }) {
    e.preventDefault();
    doSave();
  }

  return (
    <div className="min-h-screen bg-bg text-body flex flex-col">
      <AdminBar />

      <main className="flex-1 mx-auto w-full max-w-[900px] px-6 py-10 pb-28">
        {/* Page header */}
        <div className="mb-8">
          <Link
            to="/admin"
            className="inline-flex items-center gap-2 text-sm text-muted hover:text-title transition-colors"
          >
            <ArrowLeft size={15} strokeWidth={1.5} /> Back to projects
          </Link>
          <h1 className="mt-5 text-2xl font-semibold text-heading tracking-tight">
            Create project
          </h1>
          <p className="mt-1 text-sm text-muted">
            Fill in the details below. Visibility flags control what recruiters see.
          </p>
        </div>

        <form onSubmit={handleSave} className="space-y-6">
          {/* Basics */}
          <FormSection title="Basics">
            <div className="grid sm:grid-cols-2 gap-5">
              <Field label="Title" id="title">
                <input
                  id="title"
                  className={inputCls}
                  placeholder="EV Charging Platform"
                  value={form.title}
                  onChange={(e) => set("title", e.target.value)}
                />
              </Field>
              <Field label="Slug" id="slug">
                <input
                  id="slug"
                  className={inputCls}
                  placeholder="ev-charging-platform"
                  value={form.slug}
                  onChange={(e) => set("slug", e.target.value)}
                />
              </Field>
              <Field label="Role" id="role">
                <input
                  id="role"
                  className={inputCls}
                  placeholder="Lead Mobile Developer"
                  value={form.role}
                  onChange={(e) => set("role", e.target.value)}
                />
              </Field>
              <Field label="Employment type" id="employmentType">
                <select
                  id="employmentType"
                  className={inputCls}
                  value={form.employmentType}
                  onChange={(e) => set("employmentType", e.target.value)}
                >
                  <option>Full-time</option>
                  <option>Contract</option>
                  <option>Freelance</option>
                  <option>Part-time</option>
                </select>
              </Field>
              <Field label="Company" id="company">
                <input
                  id="company"
                  className={inputCls}
                  placeholder="HBit Technology LLC"
                  value={form.company}
                  onChange={(e) => set("company", e.target.value)}
                />
              </Field>
              <Field label="Client" id="client">
                <input
                  id="client"
                  className={inputCls}
                  placeholder="Enterprise client (optional)"
                  value={form.client}
                  onChange={(e) => set("client", e.target.value)}
                />
              </Field>
              <Field label="Duration" id="duration">
                <input
                  id="duration"
                  className={inputCls}
                  placeholder="10 months"
                  value={form.duration}
                  onChange={(e) => set("duration", e.target.value)}
                />
              </Field>
              <Field label="Start date" id="startDate">
                <input
                  id="startDate"
                  className={inputCls}
                  placeholder="2023"
                  value={form.startDate}
                  onChange={(e) => set("startDate", e.target.value)}
                />
              </Field>
              <Field label="End date" id="endDate">
                <input
                  id="endDate"
                  className={inputCls}
                  placeholder="2024 (leave blank if ongoing)"
                  value={form.endDate}
                  onChange={(e) => set("endDate", e.target.value)}
                  disabled={form.currentlyWorking}
                />
              </Field>
              <div className="flex items-center gap-3 pt-6">
                <Toggle
                  id="currentlyWorking"
                  checked={form.currentlyWorking}
                  onChange={(v) => set("currentlyWorking", v)}
                />
                <label htmlFor="currentlyWorking" className="text-sm text-title cursor-pointer">
                  Currently working on this
                </label>
              </div>
            </div>
          </FormSection>

          {/* Content */}
          <FormSection title="Content">
            <Field label="Short description" id="shortDescription">
              <input
                id="shortDescription"
                className={inputCls}
                placeholder="One-line summary shown on project cards"
                value={form.shortDescription}
                onChange={(e) => set("shortDescription", e.target.value)}
              />
            </Field>
            <Field label="Full description" id="fullDescription">
              <textarea
                id="fullDescription"
                rows={4}
                className={textareaCls}
                placeholder="Detailed overview of the project..."
                value={form.fullDescription}
                onChange={(e) => set("fullDescription", e.target.value)}
              />
            </Field>
            <Field label="Problem statement" id="problemStatement">
              <textarea
                id="problemStatement"
                rows={3}
                className={textareaCls}
                placeholder="What problem did this solve?"
                value={form.problemStatement}
                onChange={(e) => set("problemStatement", e.target.value)}
              />
            </Field>
            <Field label="Solution" id="solution">
              <textarea
                id="solution"
                rows={3}
                className={textareaCls}
                placeholder="How did you solve it?"
                value={form.solution}
                onChange={(e) => set("solution", e.target.value)}
              />
            </Field>
            <Field label="Responsibilities (one per line)" id="responsibilities">
              <textarea
                id="responsibilities"
                rows={4}
                className={textareaCls}
                placeholder={"Architected the Flutter client\nBuilt real-time availability flows"}
                value={form.responsibilities}
                onChange={(e) => set("responsibilities", e.target.value)}
              />
            </Field>
            <Field label="Key features (one per line)" id="keyFeatures">
              <textarea
                id="keyFeatures"
                rows={3}
                className={textareaCls}
                placeholder={"Live map of charger availability\nIn-app payments"}
                value={form.keyFeatures}
                onChange={(e) => set("keyFeatures", e.target.value)}
              />
            </Field>
          </FormSection>

          {/* Tech & platforms */}
          <FormSection title="Tech & Platforms">
            <Field label="Technologies (comma separated)" id="technologies">
              <input
                id="technologies"
                className={inputCls}
                placeholder="Flutter, ASP.NET Core, SQL Server"
                value={form.technologies}
                onChange={(e) => set("technologies", e.target.value)}
              />
            </Field>
            <div>
              <p className="text-sm font-medium text-title mb-3">Platforms</p>
              <div className="flex flex-wrap gap-4">
                {(
                  [
                    { key: "platformAndroid", label: "Android" },
                    { key: "platformIOS", label: "iOS" },
                    { key: "platformWeb", label: "Web" },
                  ] as { key: keyof FormState; label: string }[]
                ).map(({ key, label }) => (
                  <label key={label} className="flex items-center gap-2.5 cursor-pointer">
                    <input
                      type="checkbox"
                      checked={form[key] as boolean}
                      onChange={(e) => set(key, e.target.checked)}
                      className="w-4 h-4 rounded border-border bg-card"
                    />
                    <span className="text-sm text-body">{label}</span>
                  </label>
                ))}
              </div>
            </div>
          </FormSection>

          {/* Media & links */}
          <FormSection title="Media & Links">
            <div className="grid sm:grid-cols-2 gap-5">
              <Field label="Thumbnail URL" id="thumbnail">
                <input
                  id="thumbnail"
                  className={inputCls}
                  placeholder="https://..."
                  value={form.thumbnail}
                  onChange={(e) => set("thumbnail", e.target.value)}
                />
              </Field>
              <Field label="Cover image URL" id="coverImage">
                <input
                  id="coverImage"
                  className={inputCls}
                  placeholder="https://..."
                  value={form.coverImage}
                  onChange={(e) => set("coverImage", e.target.value)}
                />
              </Field>
              <Field label="GitHub URL" id="githubUrl">
                <input
                  id="githubUrl"
                  className={inputCls}
                  placeholder="https://github.com/..."
                  value={form.githubUrl}
                  onChange={(e) => set("githubUrl", e.target.value)}
                />
              </Field>
              <Field label="Live URL" id="liveUrl">
                <input
                  id="liveUrl"
                  className={inputCls}
                  placeholder="https://..."
                  value={form.liveUrl}
                  onChange={(e) => set("liveUrl", e.target.value)}
                />
              </Field>
              <Field label="Play Store URL" id="playStoreUrl">
                <input
                  id="playStoreUrl"
                  className={inputCls}
                  placeholder="https://play.google.com/..."
                  value={form.playStoreUrl}
                  onChange={(e) => set("playStoreUrl", e.target.value)}
                />
              </Field>
              <Field label="App Store URL" id="appStoreUrl">
                <input
                  id="appStoreUrl"
                  className={inputCls}
                  placeholder="https://apps.apple.com/..."
                  value={form.appStoreUrl}
                  onChange={(e) => set("appStoreUrl", e.target.value)}
                />
              </Field>
            </div>
          </FormSection>

          {/* Visibility flags — highlighted panel */}
          <FormSection title="Visibility Flags" highlight>
            <p className="text-sm text-muted -mt-2">
              These flags control what recruiters and visitors see on the public portfolio. Review carefully before publishing.
            </p>
            <div className="space-y-5 mt-2">
              <FlagRow
                id="featured"
                label="Featured"
                description="Pin this project to the home page hero and the featured projects grid."
                checked={form.featured}
                onChange={(v) => set("featured", v)}
              />
              <div className="h-px bg-divider" />
              <FlagRow
                id="privateProject"
                label="Private project (NDA)"
                description="Mask client and company name. The project still appears but identifying details are hidden."
                checked={form.privateProject}
                onChange={(v) => set("privateProject", v)}
                accent="purple"
              />
              <div className="h-px bg-divider" />
              <FlagRow
                id="canShowScreenshots"
                label="Show gallery"
                description="Show screenshots and cover image. Off = metrics-only view with no images (NDA-safe)."
                checked={form.canShowScreenshots}
                onChange={(v) => set("canShowScreenshots", v)}
              />
              <div className="h-px bg-divider" />
              <FlagRow
                id="canShowCompanyName"
                label="Show company name"
                description="Display the company and client name publicly. Disable for confidential engagements."
                checked={form.canShowCompanyName}
                onChange={(v) => set("canShowCompanyName", v)}
              />
            </div>
          </FormSection>
        </form>
      </main>

      {/* Sticky footer */}
      <div className="fixed bottom-0 left-0 right-0 h-16 border-t border-divider bg-bg-secondary flex items-center justify-between px-6 z-50">
        <Link
          to="/admin"
          className="inline-flex items-center gap-2 text-sm text-muted hover:text-title transition-colors"
        >
          <ArrowLeft size={15} strokeWidth={1.5} /> Cancel
        </Link>
        <button
          type="button"
          onClick={doSave}
          disabled={saving}
          className={`inline-flex items-center gap-2 h-10 px-5 rounded-btn text-sm font-semibold transition-colors ${
            saved
              ? "bg-green/20 text-green border border-green/30"
              : "bg-primary text-bg hover:bg-primary-hover"
          } disabled:opacity-60`}
        >
          {saving ? (
            <>
              <span className="w-4 h-4 rounded-full border-2 border-bg border-t-transparent animate-spin" />
              Saving…
            </>
          ) : saved ? (
            <>
              <CheckCircle2 size={16} strokeWidth={2} />
              Saved
            </>
          ) : (
            <>
              <Save size={16} strokeWidth={1.5} />
              Save project
            </>
          )}
        </button>
      </div>
    </div>
  );
}

// ─── Flag row helper ──────────────────────────────────────────────────────────
function FlagRow({
  id,
  label,
  description,
  checked,
  onChange,
  accent,
}: {
  id: string;
  label: string;
  description: string;
  checked: boolean;
  onChange: (v: boolean) => void;
  accent?: "purple";
}) {
  return (
    <div className="flex items-start justify-between gap-6">
      <div className="flex-1">
        <label
          htmlFor={id}
          className={`text-sm font-semibold cursor-pointer ${
            accent === "purple" ? "text-purple" : "text-heading"
          }`}
        >
          {label}
        </label>
        <p className="mt-0.5 text-xs text-muted leading-relaxed">{description}</p>
      </div>
      <Toggle id={id} checked={checked} onChange={onChange} />
    </div>
  );
}

// ─── handleSave needs to be accessible from the sticky footer ─────────────────
// The footer calls onClick={handleSave} directly — the form onSubmit also fires.
// We define handleSave inside the component so it closes over state correctly.
// The footer button is NOT inside the <form> tag, so we use onClick instead of
// relying on form submission — this is intentional.
