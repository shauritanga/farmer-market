/**
 * Accepts a Tanzanian mobile number in any of the common input shapes
 * (`+255712345678`, `255712345678`, `0712345678`) and normalizes it to
 * E.164 (`+255712345678`) — same three shapes RealMoney's borrower app
 * accepts. Anything else is returned unchanged so `@IsPhoneNumber('TZ')`
 * rejects it with a clear validation error rather than this silently
 * producing garbage.
 */
export function normalizePhoneNumber(value: unknown): unknown {
  if (typeof value !== 'string') return value;
  const trimmed = value.trim();
  if (trimmed.startsWith('+255')) return trimmed;
  if (trimmed.startsWith('255')) return `+${trimmed}`;
  if (trimmed.startsWith('0')) return `+255${trimmed.slice(1)}`;
  return trimmed;
}
