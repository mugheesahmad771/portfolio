interface Props {
  label: string;
  size?: "sm" | "md";
}

export function TechChip({ label, size = "md" }: Props) {
  const pad = size === "sm" ? "px-3 py-1 text-xs" : "px-4 py-1.5 text-[13px]";
  return (
    <span
      className={`inline-flex items-center rounded-pill bg-card-2 border border-border text-body font-mono ${pad} hover:border-primary transition-colors`}
    >
      {label}
    </span>
  );
}
