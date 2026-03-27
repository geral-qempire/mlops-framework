import argparse
from pathlib import Path

import joblib
import pandas as pd


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--model-input", required=True)
    parser.add_argument("--input-data", required=True)
    parser.add_argument("--predictions", required=True)
    args = parser.parse_args()

    model_path = Path(args.model_input) / "model.joblib"
    input_data_path = Path(args.input_data)
    predictions_path = Path(args.predictions)

    if not model_path.exists():
        raise FileNotFoundError(f"Model file not found: {model_path}")

    model = joblib.load(model_path)
    input_df = pd.read_csv(input_data_path)
    features_df = input_df.drop(columns=["target"], errors="ignore")
    prediction_values = model.predict(features_df)

    output_df = input_df.copy()
    output_df["prediction"] = prediction_values

    predictions_path.parent.mkdir(parents=True, exist_ok=True)
    output_df.to_csv(predictions_path, index=False)
    print(f"Scoring completed: predictions={predictions_path}")


if __name__ == "__main__":
    main()
