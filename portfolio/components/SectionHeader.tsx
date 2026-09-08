interface Props {
  eyebrow: string;
  title: string;
  description?: string;
  align?: "left" | "center";
}

export function SectionHeader({ eyebrow, title, description, align = "left" }: Props) {
  return (
    <div className={align === "center" ? "text-center mx-auto max-w-2xl" : "max-w-2xl"}>
      <p className="font-mono text-xs uppercase tracking-[0.2em] text-primary">{eyebrow}</p>
      <h2 className="mt-4 text-3xl lg:text-4xl font-semibold text-heading tracking-tight">
        {title}
      </h2>
      {description && (
        <p className="mt-4 text-base text-muted leading-relaxed">{description}</p>
      )}
    </div>
  );
}
