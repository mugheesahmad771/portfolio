import { ArrowLeft } from "lucide-react";
import { Button } from "../../components/Button";

export default function NotFound() {
  return (
    <div className="min-h-[60vh] grid place-items-center px-6">
      <div className="text-center max-w-md">
        <p className="font-mono text-[80px] lg:text-[120px] font-semibold text-heading leading-none tracking-tight">
          404
        </p>
        <p className="mt-6 text-lg font-semibold text-title tracking-tight">
          This page shipped to a different route.
        </p>
        <p className="mt-3 text-sm text-muted">
          The URL you followed doesn't exist — it may have moved or never existed.
        </p>
        <div className="mt-8">
          <Button to="/">
            <ArrowLeft size={18} strokeWidth={1.5} />
            Back home
          </Button>
        </div>
      </div>
    </div>
  );
}
