import argparse
from pathlib import Path

import pandas as pd
from sklearn.model_selection import train_test_split


def resolve_input_csv(input_path: Path) -> Path:
    if input_path.is_file():
        return input_path

    if input_path.is_dir():
        csv_files = sorted(input_path.glob("*.csv"))
        if csv_files:
            return csv_files[0]
    raise FileNotFoundError(f"No CSV file found at: {input_path}")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--raw-data", required=True)
    parser.add_argument("--train-output", required=True)
    parser.add_argument("--test-output", required=True)
    parser.add_argument("--target-column", default="target")
    parser.add_argument("--test-size", type=float, default=0.2)
    args = parser.parse_args()

    raw_data_path = resolve_input_csv(Path(args.raw_data))
    train_output_path = Path(args.train_output)
    test_output_path = Path(args.test_output)

    df = pd.read_csv(raw_data_path)
    if args.target_column not in df.columns:
        raise ValueError(f"Target column '{args.target_column}' was not found in input data.")

    # Keep preprocessing deterministic so model training runs are reproducible.
    df = df.dropna().reset_index(drop=True)
    train_df, test_df = train_test_split(df, test_size=args.test_size, random_state=42, shuffle=True)

    train_output_path.parent.mkdir(parents=True, exist_ok=True)
    test_output_path.parent.mkdir(parents=True, exist_ok=True)
    train_df.to_csv(train_output_path, index=False)
    test_df.to_csv(test_output_path, index=False)

    print(f"Preprocess completed: train={train_output_path}, test={test_output_path}")


if __name__ == "__main__":
    main()
