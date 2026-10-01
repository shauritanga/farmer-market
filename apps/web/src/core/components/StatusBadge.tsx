export type StatusTone = 'neutral' | 'pending' | 'success' | 'error';

const TONE_STYLES: Record<StatusTone, { bg: string; fg: string }> = {
  neutral: { bg: 'var(--color-surface)', fg: 'var(--color-text-muted)' },
  pending: { bg: 'var(--color-warning-bg)', fg: 'var(--color-warning-text)' },
  success: { bg: 'var(--color-success-bg)', fg: 'var(--color-success-text)' },
  error: { bg: 'var(--color-danger-bg)', fg: 'var(--color-danger)' },
};

/** Communicates status without relying on color alone — always pair with a label. */
export function StatusBadge({ label, tone }: { label: string; tone: StatusTone }) {
  const { bg, fg } = TONE_STYLES[tone];
  return (
    <span
      style={{
        display: 'inline-block',
        padding: '2px 10px',
        borderRadius: 4,
        fontSize: 12,
        background: bg,
        color: fg,
      }}
    >
      {label}
    </span>
  );
}
