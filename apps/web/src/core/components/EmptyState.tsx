import { InboxIcon } from '@hugeicons/core-free-icons';

import { Icon } from './Icon';

export function EmptyState({ message }: { message: string }) {
  return (
    <div
      style={{
        padding: 32,
        textAlign: 'center',
        color: 'var(--color-text-muted)',
      }}
    >
      <Icon icon={InboxIcon} size={28} color="var(--color-text-muted)" />
      <p style={{ margin: '8px 0 0' }}>{message}</p>
    </div>
  );
}
