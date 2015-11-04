// Copyright 2015 Toggl Desktop developers.

#ifndef SRC_OBM_ACTION_H_
#define SRC_OBM_ACTION_H_

#include <string>

#include <json/json.h>  // NOLINT

#include "Poco/Types.h"

#include "./base_model.h"

namespace toggl {

class ObmAction : public BaseModel {
 public:
    ObmAction()
        : BaseModel()
    , experiment_id_(0)
    , key_("")
    , value_("") {}

    const std::string &Key() const {
        return key_;
    }
    void SetKey(const std::string value);

    const std::string &Value() const {
        return value_;
    }
    void SetValue(const std::string value);

    const Poco::UInt64 &ExperimentID() const {
        return experiment_id_;
    }
    void SetExperimentID(const Poco::UInt64 value);

    // Override BaseModel
    std::string String() const;
    std::string ModelName() const;
    std::string ModelURL() const;
    Json::Value SaveToJSON() const;

 private:
    Poco::UInt64 experiment_id_;
    std::string key_;
    std::string value_;
};

}  // namespace toggl

#endif  // SRC_OBM_ACTION_H_