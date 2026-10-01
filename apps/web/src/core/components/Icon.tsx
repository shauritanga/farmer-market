import { HugeiconsIcon } from '@hugeicons/react';
import type { IconSvgElement } from '@hugeicons/react';

interface IconProps {
  icon: IconSvgElement;
  size?: number;
  color?: string;
  strokeWidth?: number;
  className?: string;
}

/** Thin wrapper so feature code imports one `Icon` component instead of
 * reaching for `HugeiconsIcon` + a specific icon everywhere. */
export function Icon({
  icon,
  size = 20,
  color = 'currentColor',
  strokeWidth = 1.8,
  className,
}: IconProps) {
  return (
    <HugeiconsIcon
      icon={icon}
      size={size}
      color={color}
      strokeWidth={strokeWidth}
      className={className}
    />
  );
}
