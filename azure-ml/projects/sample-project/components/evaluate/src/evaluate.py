import argparse
import json
from pathlib import Path

import joblib
import pandas as pd
from sklearn.metrics import accuracy_score, f1_score, precision_score, recall_score


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--model-input", required=True)
    parser.add_argument("--test-data", required=True)
    parser.add_argument("--evaluation-report", required=True)
    parser.add_argument("--target-column", default="target")
    args = parser.parse_args()

    model_input_path = Path(args.model_input)
    test_data_path = Path(args.test_data)
    evaluation_report_path = Path(args.evaluation_report)
    evaluation_report_path.mkdir(parents=True, exist_ok=True)

    model_path = model_input_path / "model.joblib"
    if not model_path.exists():
        raise FileNotFoundError(f"Model file not found: {model_path}")

    df = pd.read_csv(test_data_path)
    if args.target_column not in df.columns:
        raise ValueError(f"Target column '{args.target_column}' was not found in test data.")

    x_test = df.drop(columns=[args.target_column])
    y_test = df[args.target_column]

    model = joblib.load(model_path)
    predictions = model.predict(x_test)

    metrics = {
        "accuracy": float(accuracy_score(y_test, predictions)),
        "precision": float(precision_score(y_test, predictions, average="weighted", zero_division=0)),
        "recall": float(recall_score(y_test, predictions, average="weighted", zero_division=0)),
        "f1_score": float(f1_score(y_test, predictions, average="weighted", zero_division=0)),
    }

    with (evaluation_report_path / "metrics.json").open("w", encoding="utf-8") as file:
        json.dump(metrics, file, indent=2)

    print(f"Evaluation completed: report={evaluation_report_path / 'metrics.json'}")


if __name__ == "__main__":
    main()
